//
//  CoreDataWrapper.m
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//

#import "CoreDataWrapper.h"

@implementation CoreDataWrapper


- (BOOL) storeFavourite:(NSArray *)favourites {
    
    NSManagedObjectContext *context = [CoreDataStore privateQueueContext];
    
    __block BOOL added = NO;
    
    for (NSDictionary *item in favourites) {
        NSString *title = [item objectForKey:@"Title"];
        [context performBlockAndWait:^{
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Favourites"];
        //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(Title = %@)",title];
        //[request setPredicate:pred];
            
        NSArray *results = [context executeFetchRequest:request error:nil];
            if (results == nil) {
                NSLog(@"error with core data request");
                abort();
            }
                
                NSManagedObject *newFavourite = [NSEntityDescription insertNewObjectForEntityForName:@"Favourites" inManagedObjectContext:context];
                
                [newFavourite setValue: title forKey:@"title"];
                [newFavourite setValue: [item objectForKey:@"Detail"] forKey:@"detail"];
                [newFavourite setValue: [item objectForKey:@"Url"] forKey:@"url"];
                [context save:nil];
                added = YES;
                NSLog(@"store success");
            
        }];
    }
    return added;
}


- (NSMutableArray *) getFavourits {
    
    NSManagedObjectContext *context = [CoreDataStore privateQueueContext];
    
    __block NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [context performBlockAndWait:^{
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Favourites"];
        
        NSArray *results = [context executeFetchRequest:request error:nil];
        
        if (results == nil) {
            NSLog(@"error with core data request");
            abort();
        }
        arr = [NSMutableArray arrayWithArray:results];
        
    }];
    return arr;
}

@end
