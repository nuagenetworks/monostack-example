@import <Foundation/Foundation.j>
@import <NUKit/NUModule.j>
@import "../Models/Models.j"

@global SKUsersModule
@global SKLocationsModule


@implementation SKConfigurationModule: NUModule
{
    @outlet CPButton buttonBack @accessors(readonly);

    @outlet SKUsersModule usersModule;
    @outlet SKLocationsModule locationsModule;
}


#pragma mark -
#pragma mark Initialization

+ (CPString)moduleName
{
    return @"Configuration";
}

+ (CPImage)moduleIcon
{
    return CPImageInBundle(@"toolbar-configuration.png");
}

+ (BOOL)isTableBasedModule
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [viewTitleContainer setBackgroundColor:NUSkinColorBlack];
    [viewTitleContainer setBorderBottomColor:nil];

    [self setSubModules:[usersModule, locationsModule]];
}

@end
