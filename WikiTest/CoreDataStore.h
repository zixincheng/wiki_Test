//
//  CoreDataStore.h
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStore : NSObject

+ (instancetype)defaultStore;

+ (NSManagedObjectContext *) mainQueueContext;
+ (NSManagedObjectContext *) privateQueueContext;

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, strong) NSManagedObjectContext *mainQueueContext;
@property (nonatomic, strong) NSManagedObjectContext *privateQueueContext;

@end
