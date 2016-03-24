@import <Foundation/Foundation.j>
@import <NUKit/NUModule.j>
@import "../Models/Models.j"


@implementation SKConfigurationModule: NUModule
{
    @outlet CPButton buttonBack @accessors(readonly);

    @outlet SKUsersModule usersModule;
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

    [viewTitleContainer setBackgroundColor:[CPColor colorWithHexString:@"f76961"]];
    [viewTitleContainer setBorderBottomColor:nil];

    [self setSubModules:[usersModule]];
}

@end
