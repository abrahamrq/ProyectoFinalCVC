//
//  CalendarTableViewController.m
//  ProyectoFinalCVC
//
//  Created by Michelle Juárez  on 26/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "CalendarTableViewController.h"
#import "EventViewController.h"

@interface CalendarTableViewController (){
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *when;
    NSMutableString *summary;
    NSString *element;
}

@end

@implementation CalendarTableViewController

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"entry"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        when   = [[NSMutableString alloc] init];
        title   = [[NSMutableString alloc] init];
        summary  = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"entry"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:summary forKey:@"summary"];
        [feeds addObject:[item copy]];
        
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"summary"]) {
        [summary appendString: string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *event = [feeds[indexPath.row] objectForKey: @"title"];
        NSString *sum = [feeds[indexPath.row] objectForKey: @"summary"];
        [[segue destinationViewController] setEvent:event];
        [[segue destinationViewController] setSummary:sum];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"https://www.google.com/calendar/feeds/b3ap19ompkd8filsmib6i6svbg%40group.calendar.google.com/public/basic"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    NSString *p= [[[feeds objectAtIndex:indexPath.row] objectForKey: @"summary"] stringByReplacingOccurrencesOfString:@"&eacute;"
                                                withString:@"é"];
    
    p =[p stringByReplacingOccurrencesOfString:@"<br>"
                                    withString:@""];
    p =[p stringByReplacingOccurrencesOfString:@"&aacute;"
                                    withString:@"á"];
    p =[p stringByReplacingOccurrencesOfString:@"&iacute;"
                                    withString:@"í"];
    p =[p stringByReplacingOccurrencesOfString:@"&oacute;"
                                    withString:@"ó"];
    p =[p stringByReplacingOccurrencesOfString:@"&uacute;"
                                    withString:@"ú"];
    p =[p stringByReplacingOccurrencesOfString:@"&amp;"
                                    withString:@"&"];
    p =[p stringByReplacingOccurrencesOfString:@"&nbsp;"
                                    withString:@""];
    cell.detailTextLabel.text =p;
    
    NSString *t= [[[feeds objectAtIndex:indexPath.row] objectForKey: @"title"] stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
    
    t =[t stringByReplacingOccurrencesOfString:@"<br>"
                                    withString:@""];
    t =[t stringByReplacingOccurrencesOfString:@"&aacute;"
                                    withString:@"á"];
    t =[t stringByReplacingOccurrencesOfString:@"&iacute;"
                                    withString:@"í"];
    t =[t stringByReplacingOccurrencesOfString:@"&oacute;"
                                    withString:@"ó"];
    t =[t stringByReplacingOccurrencesOfString:@"&uacute;"
                                    withString:@"ú"];
    t =[t stringByReplacingOccurrencesOfString:@"&amp;"
                                    withString:@"&"];
    t =[t stringByReplacingOccurrencesOfString:@"&nbsp;"
                                    withString:@""];
    
    cell.textLabel.text = t;
    
    // Configure the cell...
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
