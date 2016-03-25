@import <Foundation/Foundation.j>
@import <NUKit/NUModule.j>
@import "../Models/Models.j"


@implementation SKLocationsModule : NUModule

+ (CPString)moduleName
{
    return @"Locations";
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerDataViewWithName:@"locationDataView" forClass:SKLocation];
}

- (void)configureContexts
{
    var context = [[NUModuleContext alloc] initWithName:@"Location" identifier:[SKLocation RESTName]];
    [context setPopover:popover];
    [context setFetcherKeyPath:@"childrenLocations"];
    [self registerContext:context forClass:SKLocation];
}

- (BOOL)shouldManagePushOfType:(CPString)aType forEntityType:(CPString)entityType
{
    return entityType === [SKLocation RESTName];
}

- (BOOL)shouldProcessJSONObject:(id)aJSONObject ofType:(CPString)aType eventType:(CPString)anEventType
{
    return aType === [SKLocation RESTName];
}

@end
