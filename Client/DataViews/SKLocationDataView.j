@import <Foundation/Foundation.j>
@import <NUKit/NUAbstractDataView.j>


@implementation SKLocationDataView : NUAbstractDataView
{
    @outlet CPTextField fieldAddress;
    @outlet CPTextField fieldName;
}

- (void)bindDataView
{
    [super bindDataView];

    [fieldAddress bind:CPValueBinding toObject:_objectValue withKeyPath:@"address" options:nil];
    [fieldName bind:CPValueBinding toObject:_objectValue withKeyPath:@"name" options:nil];
}

- (id)initWithCoder:(CPCoder)aCoder
{
    if (self = [super initWithCoder:aCoder])
    {
        fieldAddress = [aCoder decodeObjectForKey:@"fieldAddress"];
        fieldName = [aCoder decodeObjectForKey:@"fieldName"];
    }

    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:fieldAddress forKey:@"fieldAddress"];
    [aCoder encodeObject:fieldName forKey:@"fieldName"];
}

@end
