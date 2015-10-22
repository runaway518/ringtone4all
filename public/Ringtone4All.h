#import <Foundation/Foundation.h>
@interface Ringtone4All : NSObject
+(BOOL)isReady;
+(BOOL)addRingtone: (NSString*)name fromPath: (NSString*)path isDefault:(BOOL)setDefault;
+(NSArray*)getListRingtones;
+(BOOL)deleteRingtone:(NSString*) identifier;
@end
