/*
    Header
*/

@import <Foundation/Foundation.j>
@import <NUKit/NUAbstractDataViewsLoader.j>

@import "DataViews.j"


@implementation DataViewsLoader : NUAbstractDataViewsLoader
{
    @outlet SKListDataView      listDataView     @accessors(readonly);
    @outlet SKLocationDataView  locationDataView @accessors(readonly);
    @outlet SKTaskDataView      taskDataView     @accessors(readonly);
    @outlet SKUserDataView      userDataView     @accessors(readonly);
}

@end
