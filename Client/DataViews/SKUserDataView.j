@import <Foundation/Foundation.j>
@import <NUKit/NUAbstractDataView.j>

@implementation SKUserDataView : NUAbstractDataView
{
    @outlet CPTextField fieldAge;
    @outlet CPTextField fieldFirstName;
    @outlet CPTextField fieldLastName;
    @outlet CPTextField fieldLogin;
}

- (void)bindDataView
{
    [super bindDataView];

    [fieldAge bind:CPValueBinding toObject:_objectValue withKeyPath:@"age" options:nil];
    [fieldFirstName bind:CPValueBinding toObject:_objectValue withKeyPath:@"firstName" options:nil];
    [fieldLastName bind:CPValueBinding toObject:_objectValue withKeyPath:@"lastName" options:nil];
    [fieldLogin bind:CPValueBinding toObject:_objectValue withKeyPath:@"userName" options:nil];
}

- (id)initWithCoder:(CPCoder)aCoder
{
    if (self = [super initWithCoder:aCoder])
    {
        fieldAge = [aCoder decodeObjectForKey:@"fieldAge"];
        fieldFirstName = [aCoder decodeObjectForKey:@"fieldFirstName"];
        fieldLastName = [aCoder decodeObjectForKey:@"fieldLastName"];
        fieldLogin = [aCoder decodeObjectForKey:@"fieldLogin"];
    }

    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:fieldAge forKey:@"fieldAge"];
    [aCoder encodeObject:fieldFirstName forKey:@"fieldFirstName"];
    [aCoder encodeObject:fieldLastName forKey:@"fieldLastName"];
    [aCoder encodeObject:fieldLogin forKey:@"fieldLogin"];
}

@end
