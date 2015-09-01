//
//  ViewController.m
//  StackOverFlow
//
//  Created by Aman Jain on 18/08/15.
//  Copyright (c) 2015 Aman. All rights reserved.
//

#import "ViewController.h"
#import "Question.h"
#import "tableViewCell.h"
#import "Reachability.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) WebViewController *webview;
@property (nonatomic, strong) UILabel *messageLabel;


@end

@implementation ViewController

@synthesize messageLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchResults = [[NSMutableArray alloc] init];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    // Display a message when the table is empty
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    messageLabel.text = @"👆🏼Tap on Search box to search Question.";
    messageLabel.textColor = [UIColor colorWithRed:0.9082 green:0.9264 blue:0.9317 alpha:1.0];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    [messageLabel sizeToFit];
    
    self.tableView.backgroundView = messageLabel;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.1686 green:0.1843 blue:0.2118 alpha:1.0];
    self.tableView.separatorStyle =   UITableViewCellSeparatorStyleNone;
    
    
    
    
}

-(BOOL)IsConnected{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return !(networkStatus == NotReachable);
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

- (void)stackOverflowSearch:(NSString *)searchString
{
    searchString = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=%@&site=stackoverflow", searchString]];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
    
    NSMutableArray *tempArray = [jsonDict objectForKey:@"items"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine; //TableViewSeprator set to Default
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.6889 green:0.7137 blue:0.7345 alpha:1.0]];
    
    self.messageLabel.hidden = YES; //Hide the message label
    
    
    for (NSDictionary *tempDict in tempArray) {
        Question *question = [[Question alloc] init];
        question.title = [tempDict objectForKey:@"title"];
        question.link = [tempDict objectForKey:@"link"];
        question.answer_count = [tempDict objectForKey:@"answer_count"];
        question.display_name = [tempDict objectForKey:@"view_count"];
        [self.searchResults addObject:question];
    }
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    if([self IsConnected]){
        
        [searchBar resignFirstResponder];
        [self.searchResults removeAllObjects];
        [self stackOverflowSearch:searchBar.text];
        
    }
    
    else {
        
        //Network error if connection not available.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                        message:@"You must be connected to the internet to use this app."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.titleLabel.text = [self.searchResults[indexPath.row] title];
    cell.postview.text = [NSString stringWithFormat:@"%@",[self.searchResults[indexPath.row] display_name]];
    cell.answercount.text = [NSString stringWithFormat:@"%@", [self.searchResults[indexPath.row] answer_count]];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [self.searchResults[indexPath.row] link];
        [[segue destinationViewController] setUrl:string];
        
    }
    
}

@end
