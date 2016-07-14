//
//  ViewController.m
//  WikiTest
//
//  Created by zixin cheng on 2016-07-07.
//  Copyright © 2016 zixin. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController (){
    
    NSArray *searchResult;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apiWrapper = [[ApiWrapper alloc] init];
    //searchResult = [[NSDictionary alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searBtnPressed:(id)sender {
    
    [self searchWithContent];
}

- (IBAction)favouriteBtnPressed:(id)sender {
    [self performSegueWithIdentifier:@"favouriteSegue" sender:self];
}

-(void)searchWithContent{

    if ([self.searchBox.text  isEqual: @""]) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"ERROR"
                                              message:@"Please Enter a Keyword"
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
    [self.apiWrapper getArticle:self.searchBox.text callback:^(NSArray *responseData) {
        //NSLog(@"%@",responseData);
        
        if (responseData == NULL) {
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"ERROR"
                                                  message:@"Invalid Keyword"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:NSLocalizedString(@"OK", @"Cancel action")
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Cancel action");
                                           }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        searchResult = responseData;
        [self performSegueWithIdentifier:@"resultSegue" sender:self];
    }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"resultSegue"]) {
        ResultTableViewController *resultController = (ResultTableViewController *)segue.destinationViewController;
        resultController.searchReuslt = searchResult;
        resultController.searchKeywords = self.searchBox.text;
    } else if([segue.identifier isEqualToString:@"resultSegue"]){
        
    }

}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchWithContent];
    [textField resignFirstResponder];
    
    return YES;
}

@end
