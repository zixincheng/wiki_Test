//
//  ResultTableViewController.h
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//
#import "DetailPageViewController.h"
#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "CoreDataWrapper.h"


@interface ResultTableViewController : UITableViewController


@property (nonatomic, strong) NSArray *searchReuslt;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavouriteBtn;

@property (nonatomic, strong) NSString *searchKeywords;

@property (strong, nonatomic) CoreDataWrapper *coreDataWrapper;
@end
