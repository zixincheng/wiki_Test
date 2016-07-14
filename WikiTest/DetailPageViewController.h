//
//  DetailPageViewController.h
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIWebView+AFNetworking.h"

@interface DetailPageViewController : UIViewController

@property (nonatomic, strong) NSString *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
