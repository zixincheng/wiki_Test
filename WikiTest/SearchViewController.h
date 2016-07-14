//
//  ViewController.h
//  WikiTest
//
//  Created by zixin cheng on 2016-07-07.
//  Copyright © 2016 zixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiWrapper.h"
#import "ResultTableViewController.h"


@interface SearchViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchBox;

@property (strong, nonatomic) ApiWrapper *apiWrapper;


@end

