//
//  TableViewController.m
//  ReaderPDFDemo
//
//  Created by WhatsXie on 2017/8/14.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import "TableViewController.h"
#import "ReaderViewController.h"
#import "DocTableViewController.h"

@interface TableViewController ()<ReaderViewControllerDelegate>

@end

@implementation TableViewController{
    ReaderViewController *readerViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushPDFReaderViewController {
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
    NSString *filePath = [pdfs lastObject]; assert(filePath != nil); // Path to last PDF file
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
    
    if (document != nil) {
        readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        [self presentViewController:readerViewController animated:YES completion:^{
        }];
    }
}

#pragma mark - ReaderViewControllerDelegate methods
- (void)dismissReaderViewController:(ReaderViewController *)viewController {
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    [self.navigationController popViewControllerAnimated:YES];
#else
    [self dismissViewControllerAnimated:YES completion:NULL];
#endif 
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self pushPDFReaderViewController];
    }
}

@end
