@import <Foundation/Foundation.j>

@global SKTaskStatus_DONE
@global SKTaskStatus_PROGRESS
@global SKTaskStatus_TODO


@implementation SKStatusToColorTransformer : CPValueTransformer

+ (Class)transformedValueClass
{
    return CPColor;
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)aValue
{
    switch (aValue)
    {
        case SKTaskStatus_TODO:
            return NUSkinColorRed;

        case SKTaskStatus_PROGRESS:
            return NUSkinColorOrange;

        case SKTaskStatus_DONE:
            return NUSkinColorGreen;
    }
}

@end


// registration
SKStatusToColorTransformerName = @"SKStatusToColorTransformerName";
[CPValueTransformer setValueTransformer:[SKStatusToColorTransformer new] forName:SKStatusToColorTransformerName];
