//
//  DPDinnerOptionsTableViewController.m
//  DinnerPlans
//
//  Created by Ana Muniz on 9/23/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPDinnerOptionsTableViewController.h"
#import "DPEditDinnerOptionViewController.h"
#import "DPTabBarController.h"
#import "DPAppDelegate.h"
#import "DPScheduler.h"
#import "DPDinnerOptions.h"
#import "DPDinnerOption.h"
@interface DPDinnerOptionsTableViewController ()
{
    DPDinnerOptions *_dinnerOptions;
    NSArray *_dinnerOptionsAsArray;
    bool _addNewOption;
}
@end

@implementation DPDinnerOptionsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark Lifecyle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setEditing:NO];
    
    //_dinnerOptions = [DPDinnerOptions loadDinnerOptions] ;
    DPAppDelegate *app = (DPAppDelegate *)[[UIApplication sharedApplication] delegate] ;
    _dinnerOptions = [app dinnerOptions];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //UINavigationItem *navItem = [self navigationItem];
    
    //[navItem setTitle:@"Dinner Options"];
    
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDinnerOption:)];
    //[navItem setRightBarButtonItem:addButton];
    [[self tableView] setAllowsMultipleSelectionDuringEditing:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    // todo: save
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //if (_dinnerOptionsAsArray == nil)
    _dinnerOptionsAsArray = [_dinnerOptions options];

    // Return the number of rows in the section.
    return [_dinnerOptionsAsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dayOfWeek = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DinnerOptionCellId" forIndexPath:indexPath];
    DPDinnerOption * option = [_dinnerOptionsAsArray objectAtIndex:[indexPath row]];
    
    // Configure the cell...
    dayOfWeek = [option scheduledForDayOfWeek] ;
    if (!dayOfWeek.length)
        dayOfWeek = @"Not in the plans";
    
    [(UILabel *)[cell viewWithTag:1] setText:[option name]];
    [(UILabel *)[cell viewWithTag:2] setText:[NSString stringWithFormat:@"Last Date Served: %@",[self formatDate:[option lastDateServed]]]];
    [(UILabel *)[cell viewWithTag:3] setText:[NSString stringWithFormat:@"Planned For: %@",dayOfWeek]];
  
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    // When the user swipes to show the delete confirmation, don't enter editing mode.
    // UITableViewController enters editing mode by default so we override without calling super.
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    // When the user swipes to hide the delete confirmation, no need to exit edit mode because we didn't enter it.
    // UITableViewController enters editing mode by default so we override without calling super.
}
*/
-(UITableViewCell*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *cellIdentifier = @"DinnerOptionHeaderCellId";
    
    return [[self tableView] dequeueReusableCellWithIdentifier:cellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    //_ipCellBeingEdited = [indexPath copy];
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[_dinnerOptions options] removeObjectAtIndex:[indexPath row]];
        
        DPTabBarController * tabBarController = (DPTabBarController *)[self tabBarController];
        [tabBarController setPlansHaveChanged:YES];
        
        [tableView reloadData];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark Actions
-(IBAction) addDinnerOption:(id)sender
{
    _addNewOption = YES;
    [self performSegueWithIdentifier:@"toEditDinnerOption" sender:self];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DPEditDinnerOptionViewController *editOptionController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"toEditDinnerOption"])
    {
        __weak DPEditDinnerOptionViewController *weakRefToController = editOptionController;
        
        if (_addNewOption)
        {
            _addNewOption = NO;
            DPDinnerOption *newDinnerOption = [[DPDinnerOption alloc] init];
            [newDinnerOption setNextDateScheduled:[DPScheduler nextAvailableDate]];
            [newDinnerOption setLastDateServed:[DPScheduler yesterday]];
            [editOptionController setDinnerOption:newDinnerOption];
            [editOptionController setDismissBlock:^{
                [self handleReturnFromAddOptionController:weakRefToController];
            }];
        }
        else
        {
            
            [editOptionController setDinnerOption:[_dinnerOptionsAsArray objectAtIndex:[[[self tableView ] indexPathForSelectedRow] row]]];
            [editOptionController setDismissBlock:^{
                [self handleReturnFromEditOptionController:weakRefToController];
            }];
        }
        
        
        
        
    }
}

#pragma mark Private
-(NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    return[dateFormatter stringFromDate:date];
    
}

-(void) handleReturnFromEditOptionController:(DPEditDinnerOptionViewController*) editController
{
    
    if (![editController changed])
        return;

    //[_dinnerOptions save];
    
    DPTabBarController * tabBarController = (DPTabBarController *)[self tabBarController];
    [tabBarController setPlansHaveChanged:YES];
    
    //_dinnerOptionsAsArray = nil; //forces to reload and resort the data
    
    [[self tableView] reloadData];
}

-(void) handleReturnFromAddOptionController:(DPEditDinnerOptionViewController*) editController
{
    
    if (![editController changed])
        return;
    [_dinnerOptions addOption:[editController dinnerOption]];
    //[_dinnerOptions save];
    DPTabBarController * tabBarController = (DPTabBarController *)[self tabBarController];
    [tabBarController setPlansHaveChanged:YES];
    
    //_dinnerOptionsAsArray = nil; //forces to reload and resort the data
    
    [[self tableView] reloadData];
}

@end
