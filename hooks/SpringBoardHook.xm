%group SpringBoard
%hook SpringBoard

-(id)init{
    self = %orig;
    CPDistributedMessagingCenter *center = [CPDistributedMessagingCenter centerNamed:@"com.dofuk.RingTone4All"];
    rocketbootstrap_distributedmessagingcenter_apply(center);
    [center registerForMessageName:@"addRingtone" target:self selector:@selector(handleMessageNamed:withUserInfo:)];
    [center runServerOnCurrentThread];
    return self;
}

%new
-(NSDictionary*)handleMessageNamed: (NSString*)name withUserInfo: (NSDictionary*)userInfo{
	if ([name isEqualToString:@"addRingtone"]){
        [self addRingtone:userInfo];
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
    NSString* ringName = [NSString stringWithFormat:@"%@.m4r", randomStringWithLength(4,@"name")];

    //Copy file file to pid
    NSString* ringTonePath = [NSString stringWithFormat:@"/var/mobile/Media/iTunes_Control/Ringtones/%@", ringName];
    NSError *error;
    [fileManeger copyItemAtPath:path toPath:ringTonePath error:&error];
    if (error){
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