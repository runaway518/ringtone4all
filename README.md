Include Ringtone4All class in public directory to your project

```objective-c

+(BOOL)isReady; //To check tweak is ready or not

+(BOOL)addRingtone: (NSString*)name fromPath: (NSString*)path isDefault:(BOOL)setDefault; //To add ringtone with name, path to m4r file

+(NSArray*)getListRingtones; //Get list ringtone in device

+(BOOL)deleteRingtone: (NSString*) identifier; //Delete a ringtone 

```
