//
//  FavouriteTableViewController.m
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//

#import "FavouriteTableViewController.h"

@interface FavouriteTableViewController (){
    
    NSArray *favourties;
    NSString *selectedUrl;
}

@end

@implementation FavouriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.coreDataWrapper = [[CoreDataWrapper alloc]init];
    
    favourties = [self.coreDataWrapper getFavourits];
    
    
    if (favourties.count == 0) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"ERROR"
                                              message:@"No Favourite"
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return favourties.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSManagedObject *object =[favourties objectAtIndex:indexPath.row];
    
    cell.TitleLabel.text = [object valueForKey:@"Title"];
    cell.DetailLabel.text = [object valueForKey:@"Detail"];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object =[favourties objectAtIndex:indexPath.row];
    selectedUrl =[object valueForKey:@"Url"];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailPageViewController *detailController = (DetailPageViewController *)segue.destinationViewController;
        detailController.url = selectedUrl;
    }
}


@end
