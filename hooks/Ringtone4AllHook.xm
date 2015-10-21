%group Ringtone4All
%hook Ringtone4All
+(BOOL)isReady{
	return TRUE;
}
+(void)addRingtone: (NSString*)name fromPath: (NSString*)path isDefault:(BOOL)setDefault{
	NSNumber* isDefault = [NSNumber numberWithBool:setDefault];
	NSDictionary* ringtone = [[NSDictionary alloc]initWithObjectsAndKeys:name, @"name", path, @"path", isDefault, @"setDefault", nil];

	CPDistributedMessagingCenter *c = [CPDistributedMessagingCenter centerNamed:@"com.dofuk.RingTone4All"];
	rocketbootstrap_distributedmessagingcenter_apply(c);
	[c sendMessageName:@"addRingtone" userInfo:ringtone];
}
%end
%end