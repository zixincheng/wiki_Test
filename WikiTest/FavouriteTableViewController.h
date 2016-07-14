//
//  FavouriteTableViewController.h
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataWrapper.h"
#import "TableViewCell.h"
#import "DetailPageViewController.h"

@interface FavouriteTableViewController : UITableViewController

@property (strong, nonatomic) CoreDataWrapper *coreDataWrapper;

@end
