//
//  CoreDataWrapper.h
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStore.h"

@interface CoreDataWrapper : NSObject

- (BOOL) storeFavourite:(NSArray *)favourites;
- (NSMutableArray *) getFavourits;

@end
