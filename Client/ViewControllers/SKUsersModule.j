@import <Foundation/Foundation.j>
@import <NUKit/NUModule.j>
@import "../Models/Models.j"


@implementation SKUsersModule : NUModule
{
    @outlet CPButton buttonBack;
}

+ (CPString)moduleName
{
    return @"Users";
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerDataViewWithName:@"userDataView" forClass:SKUser];
}

- (void)configureContexts
{
    var context = [[NUModuleContext alloc] initWithName:@"Users" identifier:[SKUser RESTName]];
    [context setPopover:popover];
    [context setFetcherKeyPath:@"childrenUsers"];
    [self registerContext:context forClass:SKUser];
}

- (BOOL)shouldManagePushOfType:(CPString)aType forEntityType:(CPString)entityType
{
    return entityType === [SKUser RESTName];
}

- (BOOL)shouldProcessJSONObject:(id)aJSONObject ofType:(CPString)aType eventType:(CPString)anEventType
{
    return (aType === [SKUser RESTName]);
}

@end
