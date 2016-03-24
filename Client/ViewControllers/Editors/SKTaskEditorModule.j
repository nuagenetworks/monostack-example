@import <Foundation/Foundation.j>
@import <NUKit/NUModule.j>
@import "../../Models/Models.j"

// declare the editor modules
@class SKTaskUsersAssignationModule


@implementation SKTaskEditorModule : NUModule
{
    @outlet SKTaskUsersAssignationModule  usersAssignationModule;
}


#pragma mark -
#pragma mark Initialization

+ (CPString)moduleName
{
    return @"Users";
}

+ (BOOL)isTableBasedModule
{
    return NO;
}

+ (BOOL)moduleTabViewMode
{
    return NUModuleTabViewModeIcon;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setSubModules:[usersAssignationModule]];
}

@end
