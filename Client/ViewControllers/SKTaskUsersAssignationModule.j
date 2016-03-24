@import <Foundation/Foundation.j>
@import <NUKit/NUModuleAssignation.j>
@import "../Models/Models.j"


@implementation SKTaskUsersAssignationModule : NUModuleAssignation

+ (CPString)moduleName
{
    return @"Users";
}

+ (CPString)moduleTabIconIdentifier
{
    return @"taskusers";
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


#pragma mark -
#pragma mark NUModuleAssignation API

- (void)configureObjectsChooser:(NUObjectChooser)anObjectChooser
{
    [anObjectChooser setModuleTitle:"Assign Users"];
    [anObjectChooser registerDataViewWithName:@"userDataView" forClass:SKUser];
}

- (NUVSDObject)parentOfAssociatedObject
{
    return [SKRoot defaultUser];
}

- (void)assignObjects:(CPArray)someObjects
{
    [_currentParent assignEntities:someObjects
                           ofClass:SKUser
                   andCallSelector:nil
                          ofObject:nil];
}

@end
