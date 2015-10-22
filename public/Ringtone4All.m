#import "Ringtone4All.h"
@implementation Ringtone4All
+(BOOL)isReady{
    return FALSE;
}

+(BOOL)addRingtone: (NSString*)name fromPath: (NSString*)path isDefault:(BOOL)setDefault{
    return FALSE;
}

+(NSArray*)getListRingtones{
	return nil;
}
+(BOOL)deleteRingtone: (NSString*) identifier{
	return FALSE;
}
@end

