@import <Foundation/Foundation.j>
@import <NUKit/NUAbstractDataView.j>

@global SKStatusToColorTransformerName
@global NUNullDescriptionTransformerName

@implementation SKTaskDataView : NUAbstractDataView
{
    @outlet CPTextField fieldDescription;
    @outlet CPTextField fieldName;
    @outlet CPView      viewStatus;
}

- (void)bindDataView
{
    [super bindDataView];

    var colorTransformer = @{CPValueTransformerNameBindingOption: SKStatusToColorTransformerName},
        descriptionTransformer = @{CPValueTransformerNameBindingOption: NUNullDescriptionTransformerName};

    [fieldDescription bind:CPValueBinding toObject:_objectValue withKeyPath:@"description" options:descriptionTransformer];
    [fieldName bind:CPValueBinding toObject:_objectValue withKeyPath:@"name" options:nil];
    [viewStatus bind:@"backgroundColor" toObject:_objectValue withKeyPath:@"status" options:colorTransformer];
}

- (id)initWithCoder:(CPCoder)aCoder
{
    if (self = [super initWithCoder:aCoder])
    {
        fieldDescription = [aCoder decodeObjectForKey:@"fieldDescription"];
        fieldName = [aCoder decodeObjectForKey:@"fieldName"];
        viewStatus = [aCoder decodeObjectForKey:@"viewStatus"];

        [viewStatus setBorderRadius:100];
    }

    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:fieldDescription forKey:@"fieldDescription"];
    [aCoder encodeObject:fieldName forKey:@"fieldName"];
    [aCoder encodeObject:viewStatus forKey:@"viewStatus"];
}

@end
