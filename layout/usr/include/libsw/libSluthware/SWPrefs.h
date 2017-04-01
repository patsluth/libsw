//
//  SWPrefs.h
//  libSluthware
//
//  Created by Pat Sluth on 2015-04-21.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface SWPrefs : NSObject
{
}

@property (strong, nonatomic, readonly) NSDictionary *preferences;
@property (strong, nonatomic, readonly) NSDictionary *defaults;
@property (strong, nonatomic, readonly) NSString *application;

- (id)initWithPreferenceFilePath:(NSString *)preferencePath defaultsPath:(NSString *)defaultsPath application:(NSString *)application;

/**
 *  Reload preferences and defaults from disk. This will be called immediately after initWithPreferenceFilePath:defaultsPath
 */
- (void)refreshPrefs;

/**
 *  Save value to preferences
 *
 *  @param value       value
 *  @param key         key
 *  @param synchronize synchronize
 */
- (void)savePreferenceValue:(id)value forKey:(NSString *)key synchronize:(BOOL)synchronize;

/**
 *  Write defaults to disk
 *
 *  @param defaults    defaults
 *  @param overwriteExisting overwriteExisting
 */
- (void)writeDefaults:(NSDictionary *)defaults overwriteExisting:(BOOL)overwriteExisting;

/**
 *  Synchronize to disk
 */
- (void)synchronize;

@end




