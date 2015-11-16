/* Generated by RuntimeBrowser
   Image: /System/Library/PrivateFrameworks/ToneLibrary.framework/ToneLibrary
 */

@interface TLToneManager : NSObject {
}
+ (id)_copySharedResourcesPreferencesDomainForDomain:(id)arg1;
+ (id)_defaultToneIdentifierForAlertType:(int)arg1 accountIdentifier:(id)arg2;
+ (BOOL)_migrateLegacyToneSettings;
+ (id)_systemWideTonePreferenceKeyForAlertType:(int)arg1;
+ (id)sharedToneManager;
+ (id)sharedRingtoneManager;

- (id)_accessQueue;
- (BOOL)_addToneEntries:(id)arg1 toManifestAtPath:(id)arg2 mediaDirectory:(id)arg3 shouldSkipReload:(BOOL)arg4;
- (BOOL)_addToneToManifestAtPath:(id)arg1 metadata:(id)arg2 fileName:(id)arg3 mediaDirectory:(id)arg4;
- (id)_alertTonesByIdentifier;
- (id)_aliasForToneIdentifier:(id)arg1;
- (id)_allSyncedTones;
- (id)_baseDirectoryForAlertToneSoundFiles;
- (id)_cachedTonePreferences;
- (id)_copyITunesRingtonesFromManifestPath:(id)arg1 mediaDirectoryPath:(id)arg2;
- (id)_currentToneIdentifierForAlertType:(int)arg1 accountIdentifier:(id)arg2;
- (int)_currentToneWatchAlertPolicyForAlertType:(int)arg1;
- (int)_currentToneWatchAlertPolicyForAlertType:(int)arg1 accountIdentifier:(id)arg2;
- (int)_currentToneWatchAlertPolicyForAlertType:(int)arg1 accountIdentifier:(id)arg2 didFindPersistedWatchAlertPolicy:(BOOL*)arg3;
- (id)_currentToneWatchAlertPolicyPreferenceKeyForAlertType:(int)arg1 accountIdentifier:(id)arg2;
- (id)_defaultRingtoneName;
- (id)_defaultRingtonePath;
- (id)_defaultToneIdentifierForAlertType:(int)arg1 accountIdentifier:(id)arg2;
- (id)_deviceITunesRingtoneDirectory;
- (id)_deviceITunesRingtoneInformationPlist;
- (void)_didSetTonePreferenceSuccessfullyWithKey:(id)arg1 inDomain:(id)arg2 usingPreferencesOfKind:(unsigned int)arg3;
- (BOOL)_ensureDirectoryExistsAtPath:(id)arg1;
- (int)_evaluateOrphanEntriesCleanupStatusForcingReevaluationIfPreviouslyDone:(BOOL)arg1 returningFilePathsForFoundOrphans:(id*)arg2 wasAffectedByAccidentalToneDeletion:(BOOL*)arg3;
- (id)_fileNameFromToneIdentifier:(id)arg1 withPrefix:(id)arg2;
- (id)_filePathForToneIdentifier:(id)arg1 isValid:(BOOL*)arg2;
- (BOOL)_filePathHasSupportedExtensionForRingtone:(id)arg1;
- (void)_handleDeviceRingtonesChangedNotification;
- (void)_handleTonePreferencesChangedNotificationForPreferencesKinds:(unsigned int)arg1;
- (id)_iTunesRingtoneDirectory;
- (id)_iTunesRingtoneInformationPlist;
- (id)_iTunesToneForPID:(id)arg1;
- (id)_iTunesToneIdentifiersByPID;
- (id)_iTunesToneWithIdentifier:(id)arg1;
- (id)_iTunesTonesByIdentifier;
- (BOOL)_insertPurchasedToneMetadata:(id)arg1 fileName:(id)arg2;
- (BOOL)_insertSyncedToneMetadata:(id)arg1 fileName:(id)arg2;
- (BOOL)insertSyncedToneMetadata:(id)arg1 fileName:(id)arg2;
- (id)_installedTones;
- (id)installedTones;
- (unsigned long long)_installedTonesSize;
- (void)_loadAlertToneInfo;
- (void)_loadITunesRingtoneInfoPlistAtPath:(id)arg1;
- (void)_loadPreviewBehaviorsByDefaultIdentifier;
- (void)_loadToneIdentifierAliasMap;
- (id)_localizedNameOfToneWithIdentifier:(id)arg1;
- (int)_lockManifestAtPath:(id)arg1;
- (id)_nameForToneIdentifier:(id)arg1 isValid:(BOOL*)arg2;
- (id)_newServiceConnection;
- (void)_performBlockInAccessQueue:(id /* block */)arg1;
- (unsigned long)_previewBehaviorForDefaultIdentifier:(id)arg1;
- (id)_previewBehaviorsByDefaultIdentifier;
- (id)_previewSoundForToneIdentifier:(id)arg1;
- (void)_registerDidRequestResetSyncPostAccidentalToneDeletion;
- (void)_reloadITunesRingtonesAfterExternalChange;
- (void)_removeAllSyncedData;
- (BOOL)deleteSyncedToneByPID:(id)arg1;;
- (int)_removeOrphanedManifestEntriesReturningFilePathsForFoundOrphans:(id*)arg1;
- (id)_removeOrphanedPlistEntriesInManifestAtPath:(id)arg1 mediaDirectory:(id)arg2;
- (BOOL)_removeSyncedToneByPID:(id)arg1;
- (BOOL)_removeToneFromManifestAtPath:(id)arg1 fileName:(id)arg2;
- (BOOL)_removeTonesFromManifestAtPath:(id)arg1 fileNames:(id)arg2 shouldSkipReload:(BOOL)arg3 alreadyLockedManifest:(BOOL)arg4 removedEntries:(id*)arg5;
- (id)_rootDirectory;
- (void)_setAccessQueue:(id)arg1;
- (void)_setAlertTonesByIdentifier:(id)arg1;
- (void)_setCachedTonePreferences:(id)arg1;
- (void)_setCurrentToneWatchAlertPolicy:(int)arg1 forAlertType:(int)arg2;
- (void)_setCurrentToneWatchAlertPolicy:(int)arg1 forAlertType:(int)arg2 accountIdentifier:(id)arg3;
- (void)_setITunesToneIdentifiersByPID:(id)arg1;
- (void)_setITunesTonesByIdentifier:(id)arg1;
- (void)_setPreviewBehaviorsByDefaultIdentifier:(id)arg1;
- (void)_setShouldIgnoreNextToneDidChangeNotification:(BOOL)arg1;
- (void)_setShouldUseServiceToAccessTonePreferences:(BOOL)arg1;
- (void)_setToneIdentifierAliasMap:(id)arg1;
- (BOOL)_setToneIdentifierUsingService:(id)arg1 keyedByAccountIdentifier:(id)arg2 forPreferenceKey:(id)arg3;
- (void)_setTransientNanoPreferencesDomainAccessor:(id)arg1;
- (void)_setWatchPrefersSalientNotifications:(BOOL)arg1;
- (BOOL)_shouldIgnoreNextToneDidChangeNotification;
- (BOOL)_shouldUseServiceToAccessTonePreferences;
- (id)_systemModernSoundDirectory;
- (id)_systemNewSoundDirectory;
- (id)_systemRingtoneDirectory;
- (id)_systemSoundDirectory;
- (id)_toneIdentifierAliasMap;
- (id)_toneIdentifierForFileAtPath:(id)arg1;
- (id)_toneIdentifierForFileAtPath:(id)arg1 isValid:(BOOL*)arg2;
- (BOOL)_toneIsSettableForAlertType:(int)arg1;
- (id)_tonePreferencesFromService;
- (BOOL)_toneWithIdentifierIsDefaultRingtone:(id)arg1;
- (BOOL)_toneWithIdentifierIsITunesRingtone:(id)arg1;
- (BOOL)_toneWithIdentifierIsNonDefaultSystemRingtone:(id)arg1;
- (BOOL)_toneWithIdentifierIsSystemAlertTone:(id)arg1;
- (BOOL)_toneWithIdentifierIsValid:(id)arg1;
- (BOOL)_transferPurchasedToITunes:(id)arg1;
- (id)_transientNanoPreferencesDomainAccessor;
- (BOOL)_wasAffectedByAccidentalToneDeletion;
- (BOOL)_watchPrefersSalientNotifications;
- (id)currentToneIdentifierForAlertType:(int)arg1;
- (id)currentToneIdentifierForAlertType:(int)arg1 accountIdentifier:(id)arg2;
- (id)currentToneNameForAlertType:(int)arg1;
- (unsigned long)currentToneSoundIDForAlertType:(int)arg1;
- (unsigned long)currentToneSoundIDForAlertType:(int)arg1 accountIdentifier:(id)arg2;
- (void)dealloc;
- (id)defaultRingtoneIdentifier;
- (id)defaultToneIdentifierForAlertType:(int)arg1;
- (id)filePathForToneIdentifier:(id)arg1;
- (void)importTone:(id)arg1 metadata:(id)arg2 completionBlock:(id /* block */)arg3;
- (id)init;
- (id)initWithITunesRingtonePlistAtPath:(id)arg1;
- (id)nameForToneIdentifier:(id)arg1;
- (id)newAVItemForToneIdentifier:(id)arg1;
- (void)removeImportedToneWithIdentifier:(id)arg1;
- (void)setCurrentToneIdentifier:(id)arg1 forAlertType:(int)arg2;
- (void)setCurrentToneIdentifier:(id)arg1 forAlertType:(int)arg2 accountIdentifier:(id)arg3;
- (unsigned long)soundIDForToneIdentifier:(id)arg1;
- (BOOL)toneWithIdentifierIsValid:(id)arg1;

@end
