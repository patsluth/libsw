//
//  SWPrefs.m
//  libSluthware
//
//  Created by Pat Sluth on 2015-04-25.
//
//

#import "SWPrefs.h"





@interface SWPrefs()
{
}

@property (strong, nonatomic, readwrite) NSDictionary *preferences;
@property (strong, nonatomic, readwrite) NSDictionary *defaults;
@property (strong, nonatomic, readwrite) NSString *application;

@property (strong, nonatomic) NSString *preferencePath;
@property (strong, nonatomic) NSString *defaultsPath;

@end





@implementation SWPrefs

#pragma mark - Init

- (id)initWithPreferenceFilePath:(NSString *)preferencePath defaultsPath:(NSString *)defaultsPath application:(NSString *)application
{
	self = [super init];
	
	if (self) {
		
		[self initialize];
		
		self.preferencePath = preferencePath;
		self.defaultsPath = defaultsPath;
		self.application = application;
		
		[self refreshPrefs];
		
	}
	
	return self;
}

- (void)initialize
{
	// Override me
}

#pragma mark - SWPrefs

- (void)refreshPrefs
{
	// Create new dictionaries with contents of file paths, in case the files don't exists
	// Then we will just have empty dictionaries, which is better than NULL
	self.preferences = [[NSDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:self.preferencePath] copyItems:YES];
	self.defaults = [[NSDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:self.defaultsPath] copyItems:YES];
	
	// Make sure all the defaults are copied into the preferences dictionary
	[self writeDefaults:self.defaults overwriteExisting:NO];
}

- (void)savePreferenceValue:(id)value forKey:(NSString *)key synchronize:(BOOL)synchronize
{
	NSMutableDictionary *mutablePreferences = [self.preferences mutableCopy];
	CFPropertyListRef cfValue = (__bridge CFPropertyListRef)value;
	CFStringRef cfKey = (__bridge CFStringRef)key;
	CFStringRef cfApplication = (__bridge CFStringRef)self.application;
	
	
	// Set value for key
	[mutablePreferences setValue:value forKey:key];
	self.preferences = [mutablePreferences copy];
	CFPreferencesSetAppValue(cfKey, cfValue, cfApplication);
	
	// Synchronize so we can read right away
	if (synchronize) {
		[self synchronize];
	}
}

- (void)writeDefaults:(NSDictionary *)defaults overwriteExisting:(BOOL)overwriteExisting
{
	for (NSString *key in self.defaults) {
		
		id value = [self.defaults valueForKey:key];
		
		if ([self.preferences valueForKey:key] == nil) { // value doesn't exist
			[self savePreferenceValue:value forKey:key synchronize:NO];
		} else if (overwriteExisting) { // preferences already contain a value for this key, so only save if overwriteExisting
			[self savePreferenceValue:value forKey:key synchronize:NO];
		}
		
	}
	
	[self synchronize];
}

- (void)synchronize
{
	CFStringRef cfApplication = (__bridge CFStringRef)self.application;
	
	[self.preferences writeToFile:self.preferencePath atomically:YES];
	CFPreferencesAppSynchronize(cfApplication);
}

@end




