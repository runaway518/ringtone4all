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
    TLToneManager* manager;
    if ([TLToneManager respondsToSelector:@selector(sharedToneManager)]){
        manager = [TLToneManager sharedToneManager];
    }else if ([TLToneManager respondsToSelector:@selector(sharedRingtoneManager)]){
        manager = [TLToneManager sharedRingtoneManager];
    }else{
        return nil;
    }

    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if ([manager respondsToSelector:@selector(_installedTones)]){
        NSArray* tones = [manager _installedTones];
        int indexKey = 0;

        for(TLITunesTone* tone in tones){
            NSString* toneDes = [NSString stringWithFormat:@"{\"name\":\"%@\",\"identifier\":\"%@\",\"file\":\"%@\"}", [tone name], [tone pid], [tone filePath]];
            [result setObject:toneDes forKey:[NSString stringWithFormat:@"%d", indexKey]];
            indexKey++;
        }
    }else if([manager respondsToSelector:@selector(installedTones)]){
        NSArray* tones = [manager installedTones];
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
    TLToneManager* manager;
    if ([TLToneManager respondsToSelector:@selector(sharedToneManager)]){
        manager = [TLToneManager sharedToneManager];
    }else if ([TLToneManager respondsToSelector:@selector(sharedRingtoneManager)]){
        manager = [TLToneManager sharedRingtoneManager];
    }else{
        return NO;
    }

    if ([manager respondsToSelector:@selector(_removeSyncedToneByPID:)])
        return [manager _removeSyncedToneByPID:identifier];
    
    if ([manager respondsToSelector:@selector(deleteSyncedToneByPID:)])
        return [manager deleteSyncedToneByPID:identifier];

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
        NSLog(@"[RingTone4All] File is not found!");
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
        NSLog(@"[RingTone4All] File is not copy!");
        return NO;
    }

    NSDictionary* metadata = [[NSDictionary alloc] initWithObjectsAndKeys:guid, @"GUID", name, @"Name", pid, @"PID", protectedContent, @"Protected Content", audioDurationSeconds, @"Total Time", nil];

    TLToneManager* manager;
    if ([TLToneManager respondsToSelector:@selector(sharedToneManager)]){
        manager = [TLToneManager sharedToneManager];
    }else if ([TLToneManager respondsToSelector:@selector(sharedRingtoneManager)]){
        manager = [TLToneManager sharedRingtoneManager];
    }else{
        NSLog(@"[RingTone4All] System is not support! Can't create instance!");
        return NO;
    }


    if([manager respondsToSelector:@selector(_insertSyncedToneMetadata:fileName:)] && [manager _insertSyncedToneMetadata:metadata fileName:ringName]){
        if (isDefault && [manager respondsToSelector:@selector(setCurrentToneIdentifier:forAlertType:)]){
            NSString* identifier = [NSString stringWithFormat:@"itunes:%@",guid];
            [manager setCurrentToneIdentifier:identifier forAlertType:1];
        }
        return YES;
    }

    if([manager respondsToSelector:@selector(insertSyncedToneMetadata:filename:)] && [manager insertSyncedToneMetadata:metadata filename:ringName]){
        if (isDefault && [manager respondsToSelector:@selector(setCurrentToneIdentifier:forAlertType:)]){
            NSString* identifier = [NSString stringWithFormat:@"itunes:%@",guid];
            [manager setCurrentToneIdentifier:identifier forAlertType:1];
        }
        return YES;
    }

    NSLog(@"[RingTone4All] System is not support! Function is not found");

    return NO;
}
%end
%end