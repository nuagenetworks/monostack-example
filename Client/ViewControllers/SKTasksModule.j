@import <Foundation/Foundation.j>
@import <NUKit/NUModule.j>
@import "../Models/Models.j"

@class SKTaskEditorModule


@implementation SKTasksModule : NUModule
{
    @outlet SKTaskEditorModule taskEditorModule;
}

+ (CPString)moduleName
{
    return @"Tasks";
}

+ (CPImage)moduleIcon
{
    return [SKTask icon];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerDataViewWithName:@"taskDataView" forClass:SKTask];
}

- (void)configureEditor:(NUEditorsViewController)anEditorController
{
    [anEditorController registerEditor:taskEditorModule forObjectsWithRESTName:[SKTask RESTName]];
}

- (void)configureContexts
{
    var context = [[NUModuleContext alloc] initWithName:@"Tasks" identifier:[SKTask RESTName]];
    [context setPopover:popover];
    [context setFetcherKeyPath:@"childrenTasks"];

    [self registerContext:context forClass:SKTask];
}

@end
