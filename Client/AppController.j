/*
    Header
*/

@import <Foundation/Foundation.j>
@import <NUKit/NUAssociators.j>
@import <NUKit/NUCategories.j>
@import <NUKit/NUControls.j>
@import <NUKit/NUDataSources.j>
@import <NUKit/NUDataViews.j>
@import <NUKit/NUDataViewsLoaders.j>
@import <NUKit/NUHierarchyControllers.j>
@import <NUKit/NUKit.j>
@import <NUKit/NUModels.j>
@import <NUKit/NUModules.j>
@import <NUKit/NUSkins.j>
@import <NUKit/NUTransformers.j>
@import <NUKit/NUUtils.j>
@import <NUKit/NUWindowControllers.j>
@import <Bambou/Bambou.j>

@import "DataViews/DataViewsLoader.j"
@import "Models/Models.j"
@import "ViewControllers/ViewControllers.j"
@import "Transformers/Transformers.j"
@import "Associators/Associators.j"


@global BRANDING_INFORMATION
@global SERVER_AUTO_URL
@global APP_BUILDVERSION
@global APP_GITVERSION


@implementation AppController : CPObject
{
    @outlet DataViewsLoader         dataViewsLoader;
    @outlet SKListsModule           listsModule;
    @outlet SKUsersModule           usersModule;
    @outlet SKConfigurationModule   configurationModule;
}


#pragma mark -
#pragma mark Initialization

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    [CPMenu setMenuBarVisible:NO];
    [dataViewsLoader load];

    var config = [[NUKit kit] moduleColorConfiguration];
    [config setObject:[CPColor colorWithHexString:@"f76961"] forKey:@"title-container-view-background"];
    [config setObject:[CPColor colorWithHexString:@"fff"] forKey:@"title-field-foreground"];
    [config setObject:[CPColor colorWithHexString:@"f76961"] forKey:@"subtitle-container-view-background"];
    [config setObject:[CPColor colorWithHexString:@"fff"] forKey:@"subtitle-field-foreground"];
    [config setObject:[CPColor colorWithHexString:@"cc433b"] forKey:@"edition-popover-title-foreground"];
    [config setObject:[CPColor colorWithHexString:@"cc433b"] forKey:@"toolbar-background"];
    [config setObject:[CPColor colorWithHexString:@"fff"] forKey:@"toolbar-foreground"];
    [config setObject:[CPColor colorWithHexString:@"cc433b"] forKey:@"chooser-popover-banner-background"];
    [config setObject:[CPColor colorWithHexString:@"fff"] forKey:@"chooser-popover-banner-foreground"];
    [[NUKit kit] setModuleColorConfiguration:config];

    // Configure NUKit
    [[NUKit kit] setCompanyName:BRANDING_INFORMATION["label-company-name"]];
    [[NUKit kit] setCompanyLogo:CPImageInBundle("Branding/logo-company.png")];
    [[NUKit kit] setApplicationName:BRANDING_INFORMATION["label-application-name"]];
    [[NUKit kit] setApplicationLogo:CPImageInBundle("Branding/logo-application.png")];
    [[NUKit kit] setCopyright:@"Copyright \u00A9 2042 My Super Company"];
    [[NUKit kit] setAutoServerBaseURL:SERVER_AUTO_URL];
    [[NUKit kit] setDelegate:self];
    [[[NUKit kit] loginWindowController] setShowsEnterpriseField:NO];
    [[NUKit kit] configureContextDefaultFirstResponderTags:[@"description", @"value", @"lastName", @"firstName", @"title", @"name"]];

    [[NUKit kit] setDelegate:self];
    [[NUKit kit] parseStandardApplicationArguments];
    [[NUKit kit] loadFrameworkDataViews];

    [[NUKit kit] setRootAPI:[SKRoot current]];

    // Modules Registration
    [[NUKit kit] registerCoreModule:listsModule];

    [[NUKit kit] registerPrincipalModule:configurationModule
                         withButtonImage:CPImageInBundle(@"toolbar-configuration.png", 32.0, 32.0)
                                altImage:CPImageInBundle(@"toolbar-configuration-pressed.png", 32.0, 32.0)
                                 toolTip:@"Open Configuration"
                              identifier:@"button-toolbar-configuration"
                        availableToRoles:nil];


    // Make NUKit listening to internal notifications.
    [[NUKit kit] startListenNotification];
    [[NUKit kit] manageLoginWindow];

    [[[NUKitToolBar defaultToolBar] buttonLogout] setValue:CPImageInBundle(@"toolbar-logout-red.png", 32.0, 32.0) forThemeAttribute:@"image" inState:CPThemeStateNormal];
}

- (IBAction)openInspector:(id)aSender
{
    [[NUKit kit] openInspectorForSelectedObject];
}

- (void)applicationDidLogin:(NUKit)aKit
{
    // makes everyone a root guy!
    [[SKRoot current] setRole:NUPermissionLevelRoot];
}

@end
