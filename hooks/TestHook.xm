%group TestApp
%hook VuNVTest
-(void)doTest{
	NSLog(@"Call doTest");
	NSString* name = @"test";
	NSString* path = @"/var/mobile/Media/Downloads/test.m4r";
	NSNumber* setDefault = [NSNumber numberWithBool:YES];
	NSDictionary* ringtone = [[NSDictionary alloc]initWithObjectsAndKeys:name, @"name", path, @"path", setDefault, @"setDefault", nil];

	CPDistributedMessagingCenter *c = [CPDistributedMessagingCenter centerNamed:@"com.dofuk.RingTone4All"];
	rocketbootstrap_distributedmessagingcenter_apply(c);
	[c sendMessageName:@"addRingtone" userInfo:ringtone];
}

%end
%end

