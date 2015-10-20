%group SpringBoard
%hook SpringBoard

-(id)init{
    self = %orig;
    CPDistributedMessagingCenter *center = [CPDistributedMessagingCenter centerNamed:@"com.dofuk.RingTone4All"];
    rocketbootstrap_distributedmessagingcenter_apply(center);
    [center registerForMessageName:@"addRingtone" target:self selector:@selector(processMessageNamed:withInfo:)];
    [center runServerOnCurrentThread];
    return self;
}

%new
-(NSDictionary*)processMessageNamed: (NSString*)name withInfo: (NSDictionary*)info{
	if ([name isEqualToString:@"addRingtone"]){
        [self addRingtone:info];
		return nil;
    }else{
        return nil;
    }
}

%new
- (void) addRingtone: (NSDictionary*)ringTone{
    NSString* name = [ringTone objectForKey:@"name"];
    NSString* path = [ringTone objectForKey:@"path"];
    BOOL isDefault = [[ringTone objectForKey:@"setDefault"] boolValue];

    NSFileManager* fileManeger = [NSFileManager defaultManager];

    //Check path exists
    if(![fileManeger fileExistsAtPath:path]){
        return;
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
        return;
    }

    NSDictionary* metadata = [[NSDictionary alloc] initWithObjectsAndKeys:guid, @"GUID", name, @"Name", pid, @"PID", protectedContent, @"Protected Content", audioDurationSeconds, @"Total Time", nil];
    TLToneManager* manager = [TLToneManager sharedToneManager];

    [manager _insertSyncedToneMetadata:metadata fileName:ringName];

    if (isDefault){
        NSString* identifier = [NSString stringWithFormat:@"itunes:%@",guid];
        [manager setCurrentToneIdentifier:identifier forAlertType:1];
    }
}
%end
%end