//
//  DetailPageViewController.m
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//

#import "DetailPageViewController.h"

@interface DetailPageViewController ()

@end

@implementation DetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loading startAnimating];
    NSURL *URL = [NSURL URLWithString:_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    //NSProgress *progress;
    
    
    [self.webView loadRequest:request progress:nil success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loading setHidden:YES];
            [self.loading stopAnimating];
        });
        return @"success";
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"fail");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loading setHidden:YES];
            [self.loading stopAnimating];
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"ERROR"
                                                  message:@"Network Connection Error"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                        
                                           }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }];
    


    
    
    //NSURLRequest *urlRequest = [NSURLRequest requestWithURL:newurl];
    //[_webView loadRequest:urlRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
