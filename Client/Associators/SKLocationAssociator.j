@import <Foundation/Foundation.j>
@import <NUKit/NUAbstractSimpleObjectAssociator.j>
@import "../Models/Models.j"


@implementation SKLocationAssociator : NUAbstractSimpleObjectAssociator

- (CPArray)currentActiveContextIdentifiers
{
    return [[SKLocation RESTName]];
}

- (CPDictionary)associatorSettings
{
    // Dictionary containing information for each
    // kind of associated objects
    return @{
                [SKLocation RESTName]: @{
                    // This key tells what registered data view to use for the associated object
                    NUObjectAssociatorSettingsDataViewNameKey: @"locationDataView",

                    // This key tells what fetcher keyPath to use to retrieve in the associated objects
                    NUObjectAssociatorSettingsAssociatedObjectFetcherKeyPathKey: @"childrenLocations"
                }
            };
}

- (CPString)emptyAssociatorTitle
{
    // Title of the associator when nothing is associated
    return @"No selected location";
}

- (CPString)titleForObjectChooser
{
    // Title of the object chooser
    return @"Select a location";
}

- (CPString)keyPathForAssociatedObjectID
{
    // KeyPath of the association key
    return @"associatedLocationID";
}

- (NUVSDObject)parentOfAssociatedObjects
{
    // Returns the instance of the parent object
    // where the possible associated objects will be fetched from.
    return [SKRoot current];
}

@end
