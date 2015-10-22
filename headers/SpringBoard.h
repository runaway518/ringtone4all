@interface SpringBoard : NSObject {
}
- (NSDictionary*)getRingtones;
- (BOOL)deleteRingtone: (NSDictionary*)ringTone;
- (BOOL) addRingtone: (NSDictionary*)ringTone;
@end