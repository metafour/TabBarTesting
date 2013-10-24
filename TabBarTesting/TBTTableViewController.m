//
//  TBTTableViewController.m
//  TabBarTesting
//
//  Created by Camron Schwoegler on 10/23/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "TBTTableViewController.h"
#import "HNRSSChannel.h"
#import "HNRSSItem.h"
#import "TBTFirstViewController.h"
#import "TBTSecondViewController.h"

@interface TBTTableViewController ()

@end

@implementation TBTTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self fetchEntries];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self fetchEntries];
    [[self navigationItem] setTitle:@"HN"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setRefreshControl:[[UIRefreshControl alloc] init]];
    [[self refreshControl] setTintColor:[UIColor purpleColor]];
    [[self refreshControl] addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)fetchEntries
{
    // object to contain response
    xmlData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"https://news.ycombinator.com/rss"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    dataConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)refreshTable:(UIRefreshControl *)rc
{
    [self fetchEntries];
    [rc endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[channel items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    // Configure the cell...
    HNRSSItem *item = [[channel items] objectAtIndex:[indexPath row]];
    
    UILabel *cellLabel = [cell textLabel];
    UILabel *cellDetailLabel = [cell detailTextLabel];
    NSString *hostname = [[[item link] componentsSeparatedByString:@"/"] objectAtIndex:2];
    
    // cellLabel properties
    [cellLabel setNumberOfLines:0];
    [cellLabel setFont:[UIFont systemFontOfSize:12]];
    [cellLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    if ([item read] == YES) {
        [cellLabel setTextColor:[UIColor purpleColor]];
    }
//    else {
//        [cellLabel setTextColor:[UIColor blackColor]];
//    }
    
    // cellDetailLabel properties
    [cellDetailLabel setFont:[UIFont systemFontOfSize:10]];
    [cellDetailLabel setTextColor:[UIColor lightGrayColor]];
    
    // set label contents
    [cellLabel setText:[item title]];
    [cellDetailLabel setText:hostname];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    HNRSSItem *item = [[channel items] objectAtIndex:[indexPath row]];
//    [item setRead:YES];
//    
//    //    HNRSSDetailViewController *dvc = [[HNRSSDetailViewController alloc] init];
//    //    [dvc setItem:item];
//    
//    TBTFirstViewController *webView = [[TBTFirstViewController alloc] init];
//    [webView setItem:item];
//    //    [[self navigationController] pushViewController:webView animated:YES];
//    UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:webView];
//    
//    HNRSSWebViewController *webView2 = [[HNRSSWebViewController alloc] init];
//    [webView2 setItem:item];
//    [webView2 setComments:YES];
//    UINavigationController *navControl2 = [[UINavigationController alloc] initWithRootViewController:webView2];
//    
//    UITabBarController *tbc = [[UITabBarController alloc] init];
//    
//    NSArray *tabControllers = [[NSArray alloc] initWithObjects:navControl, navControl2, nil];
//    [tbc setViewControllers:tabControllers];
//    
//    //    [window setRootViewController:tbc];
//    [self presentViewController:tbc animated:YES completion:NULL];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     HNRSSItem *item = [[channel items] objectAtIndex:[[[self tableView] indexPathForCell:sender] row]];
    [item setRead:YES];
    
    UITabBarController *tabBarController = [segue destinationViewController];
    UINavigationController *navController = [[tabBarController viewControllers] objectAtIndex:0];
    TBTFirstViewController *firstViewController = [[navController viewControllers] objectAtIndex:0];
    
    [firstViewController setItem:item];
    
    navController = [[tabBarController viewControllers] objectAtIndex:1];
    
    TBTSecondViewController *secondViewController = [[navController viewControllers] objectAtIndex:0];
    
    [secondViewController setItem:item];
    
    NSLog(@"Second view controller: %@\n comments link: %@", secondViewController, [item commentsLink]);
}

#pragma mark - NSURLConnectionData Delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    [parser setDelegate:self];
    
    [parser parse];
    
    xmlData = nil;
    
    dataConnection = nil;
    
    [[self tableView] reloadData];
    
    NSLog(@"%@\n%@\n%@", channel, [channel title], [channel infoString]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release unused objects
    dataConnection = nil;
    xmlData = nil;
    
    NSString *errorString = [NSString stringWithFormat:@"Failed to load data: %@", [error localizedDescription]];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Catastrophic Failure!" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];;
    
    [av show];
}

#pragma mark - NSXMLParser Delegate methods

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@", self, elementName);
    
    if ([elementName isEqual:@"channel"]) {
        channel = [[HNRSSChannel alloc] init];
        
        [channel setParentParserDelegate:self];
        
        [parser setDelegate:channel];
    }
    
}

@end
