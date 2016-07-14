//
//  ResultTableViewController.m
//  WikiTest
//
//  Created by zixin cheng on 2016-07-08.
//  Copyright © 2016 zixin. All rights reserved.
//

#import "ResultTableViewController.h"

@interface ResultTableViewController (){
    
    NSArray *resultTitle;
    NSArray *resultDetail;
    NSArray *resultUrl;
    NSString *selectedUrl;
    BOOL enableEdit;
    NSMutableArray *favouriteItem;
    
}

@end

@implementation ResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coreDataWrapper = [[CoreDataWrapper alloc] init];
    favouriteItem = [[NSMutableArray alloc]init];
    enableEdit = false;
    self.addFavouriteBtn.title = @"Add Favourite";
    resultTitle = [self.searchReuslt objectAtIndex:1];
    resultDetail = [self.searchReuslt objectAtIndex:2];
    resultUrl = [self.searchReuslt objectAtIndex:3];
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
    return resultTitle.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.TitleLabel.text = [resultTitle objectAtIndex:indexPath.row];
    cell.DetailLabel.text = [resultDetail objectAtIndex:indexPath.row];
    if (enableEdit) {
        cell.multipleTouchEnabled = true;
    } else {
        cell.multipleTouchEnabled = false;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *additem = [[NSMutableDictionary alloc]init];
    [additem setValue:[NSString stringWithString:resultTitle[indexPath.row]] forKey:@"Title"];
    [additem setValue:resultDetail[indexPath.row] forKey:@"Detail"];
    [additem setValue:resultUrl[indexPath.row] forKey:@"Url"];
    
    if (enableEdit) {
        if (thisCell.accessoryType == UITableViewCellAccessoryNone) {
            thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [favouriteItem addObject:additem];
            //[favouriteItem setObject:additem forKey:[NSString stringWithFormat:@"%@%ld",_searchKeywords,(long)indexPath.row]];
            
             }else{
            //[favouriteItem removeObjectForKey:[NSString stringWithFormat:@"%@%ld",self.searchKeywords,(long)indexPath.row]];
                [favouriteItem removeObject: additem];
            thisCell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        NSLog(@"item count %lu",(unsigned long)favouriteItem.count);
    } else {

    selectedUrl =[resultUrl objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (some condition)
        return UITableViewCellEditingStyleInsert;
    //else
      //  return UITableViewCellEditingStyleDelete;
}
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

- (IBAction)addBtnPressed:(id)sender {
    
    if (enableEdit) {
        enableEdit = false;
        self.addFavouriteBtn.title = @"Add Favourite";
        [self storeFavourites];
        [self.tableView reloadData];
    } else {
        enableEdit = true;
        self.addFavouriteBtn.title = @"Done";
    }
}

-(void)storeFavourites {
    BOOL success = [self.coreDataWrapper storeFavourite:favouriteItem];
    if (success) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Success"
                                              message:@"Successful Store Favourites"
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
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailPageViewController *detailController = (DetailPageViewController *)segue.destinationViewController;
        detailController.url = selectedUrl;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
