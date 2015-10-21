#import <Foundation/Foundation.h>
@interface Ringtone4All : NSObject
+(BOOL)isReady;
+(void)addRingtone: (NSString*)name fromPath: (NSString*)path isDefault:(BOOL)setDefault;
@end
