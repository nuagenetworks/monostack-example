@import <Foundation/Foundation.j>
@import <NUKit/NUModule.j>
@import "../Models/Models.j"

@class SKTasksModule


@implementation SKListsModule : NUModule
{
    @outlet SKTasksModule tasksModule;
    @outlet SKLocationAssociator locationAssociator;
}

+ (BOOL)automaticSelectionSaving
{
    return NO;
}

+ (CPString)moduleName
{
    return @"Lists";
}

+ (CPImage)moduleIcon
{
    return [SKList icon];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerDataViewWithName:@"listDataView" forClass:SKList];

    [self setSubModules:[tasksModule]];
}

- (void)configureContexts
{
    var context = [[NUModuleContext alloc] initWithName:@"Lists" identifier:[SKList RESTName]];
    [context setPopover:popover];
    [context setFetcherKeyPath:@"childrenLists"];
    [self registerContext:context forClass:SKList];
}

- (BOOL)shouldManagePushOfType:(CPString)aType forEntityType:(CPString)entityType
{
    return entityType === [SKList RESTName];
}

- (BOOL)shouldProcessJSONObject:(id)aJSONObject ofType:(CPString)aType eventType:(CPString)anEventType
{
    return (aType === [SKList RESTName]);
}

- (void)moduleContext:(NUModuleContext)aContext willManageObject:(NURESTObject)anObject
{
    [locationAssociator setCurrentParent:anObject];
}

- (void)moduleContext:(NUModuleContext)aContext didManageObject:(NURESTObject)anObject
{
    [locationAssociator setCurrentParent:nil];
}

@end
