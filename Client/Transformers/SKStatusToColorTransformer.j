@import <Foundation/Foundation.j>

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
        case @"TODO":
            return NUSkinColorRed;

        case @"DONE":
            return NUSkinColorGreen;
    }
}

@end


// registration
SKStatusToColorTransformerName = @"SKStatusToColorTransformerName";
[CPValueTransformer setValueTransformer:[SKStatusToColorTransformer new] forName:SKStatusToColorTransformerName];
