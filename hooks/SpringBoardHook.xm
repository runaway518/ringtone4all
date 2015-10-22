%group SpringBoard
%hook SpringBoard

-(id)init{
    self = %orig;
    CPDistributedMessagingCenter *center = [CPDistributedMessagingCenter centerNamed:@"com.dofuk.RingTone4All"];
    rocketbootstrap_distributedmessagingcenter_apply(center);
    [center registerForMessageName:@"addRingtone" target:self selector:@selector(processMessageNamed:withInfo:)];
    [center registerForMessageName:@"getRingtones" target:self selector:@selector(processMessageNamed:withInfo:)];
    [center registerForMessageName:@"deleteRingtone" target:self selector:@selector(processMessageNamed:withInfo:)];
    [center runServerOnCurrentThread];
    return self;
}

%new
-(NSDictionary*)processMessageNamed: (NSString*)name withInfo: (NSDictionary*)info{
	if ([name isEqualToString:@"addRingtone"]){
        NSNumber* status = [NSNumber numberWithBool:[self addRingtone:info]];
        return [[NSDictionary alloc] initWithObjectsAndKeys:status, @"status", nil];
    }else if([name isEqualToString:@"getRingtones"]){
        return [self getRingtones];
    }else if([name isEqualToString:@"deleteRingtone"]){
        NSNumber* status = [NSNumber numberWithBool:[self deleteRingtone:info]];
        return [[NSDictionary alloc] initWithObjectsAndKeys:status, @"status", nil];
    }else{
        return nil;
    }
}

%new
- (NSDictionary*)getRingtones{
    TLToneManager* manager = [TLToneManager sharedToneManager];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if ([manager respondsToSelector:@selector(_installedTones)]){
        NSArray* tones = [manager _installedTones];
        int indexKey = 0;

        for(TLITunesTone* tone in tones){
            NSString* toneDes = [NSString stringWithFormat:@"{\"name\":\"%@\",\"identifier\":\"%@\",\"file\":\"%@\"}", [tone name], [tone pid], [tone filePath]];
            [result setObject:toneDes forKey:[NSString stringWithFormat:@"%d", indexKey]];
            indexKey++;
        }
    }

    return result;
}

%new
- (BOOL)deleteRingtone: (NSDictionary*)ringTone{
    NSString* identifier = [ringTone objectForKey:@"identifier"];
    TLToneManager* manager = [TLToneManager sharedToneManager];
    if ([manager respondsToSelector:@selector(_removeSyncedToneByPID:)])
        return [manager _removeSyncedToneByPID:identifier];
    return NO;
}

%new
- (BOOL) addRingtone: (NSDictionary*)ringTone{
    NSString* name = [ringTone objectForKey:@"name"];
    NSString* path = [ringTone objectForKey:@"path"];
    BOOL isDefault = [[ringTone objectForKey:@"setDefault"] boolValue];

    NSFileManager* fileManeger = [NSFileManager defaultManager];

    //Check path exists
    if(![fileManeger fileExistsAtPath:path]){
        return NO;
    }

    //Get duration
    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:path] options:nil];
    CMTime audioDuration = audioAsset.duration;
    NSInteger audioDurationSeconds = (NSInteger)(1000*CMTimeGetSeconds(audioDuration));

    //Generate PID
    NSString* pid = randomStringWithLength(19,@"PID");
    NSString* guid = randomStringWithLength(16,@"GUID");;
    NSInteger protectedContent = 0;

    NSError *error;

    //Create folder if not exists
    if (![fileManeger fileExistsAtPath:@"/var/mobile/Media/iTunes_Control"]){
        [fileManeger createDirectoryAtPath:@"/var/mobile/Media/iTunes_Control" withIntermediateDirectories:NO attributes:nil error:&error];
    }

    if (![fileManeger fileExistsAtPath:@"/var/mobile/Media/iTunes_Control/Ringtones"]){
        [fileManeger createDirectoryAtPath:@"/var/mobile/Media/iTunes_Control/Ringtones" withIntermediateDirectories:NO attributes:nil error:&error];
    }

    //Copy file file to pid
    NSString* ringName;
    NSString* ringTonePath;
    do {
        ringName = [NSString stringWithFormat:@"%@.m4r", randomStringWithLength(4,@"name")];
        ringTonePath = [NSString stringWithFormat:@"/var/mobile/Media/iTunes_Control/Ringtones/%@", ringName];
    }while([fileManeger fileExistsAtPath:ringTonePath]);

    [fileManeger copyItemAtPath:path toPath:ringTonePath error:nil];
    if (![fileManeger fileExistsAtPath:ringTonePath]){
        return NO;
    }

    NSDictionary* metadata = [[NSDictionary alloc] initWithObjectsAndKeys:guid, @"GUID", name, @"Name", pid, @"PID", protectedContent, @"Protected Content", audioDurationSeconds, @"Total Time", nil];
    TLToneManager* manager = [TLToneManager sharedToneManager];

    if([manager respondsToSelector:@selector(_insertSyncedToneMetadata:fileName:)] && [manager _insertSyncedToneMetadata:metadata fileName:ringName]){
        if (isDefault && [manager respondsToSelector:@selector(setCurrentToneIdentifier:forAlertType:)]){
            NSString* identifier = [NSString stringWithFormat:@"itunes:%@",guid];
            [manager setCurrentToneIdentifier:identifier forAlertType:1];
        }
        return YES;
    }

    return NO;
}
%end
%end