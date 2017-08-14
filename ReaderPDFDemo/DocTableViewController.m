//
//  DocTableViewController.m
//  ReaderPDFDemo
//
//  Created by WhatsXie on 2017/8/14.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import "DocTableViewController.h"
#import "ReaderViewController.h"
#import "GIFViewController.h"

@interface DocTableViewController ()<ReaderViewControllerDelegate>

@end

@implementation DocTableViewController{
    ReaderViewController *readerViewController;
}
@synthesize dirArray;
@synthesize docInteractionController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupDataInDoc];
}

- (void)setupDataInDoc {
    // image
    UIImage *image = [UIImage imageNamed:@"testPic.jpg"];
    NSData *jpgData = UIImageJPEGRepresentation(image, 0.8);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"testPic.jpg"]; //Add the file name
    [jpgData writeToFile:filePath atomically:YES]; //Write the file
    
    // text
    char *saves = "Colin_csdn";
    NSData *data = [[NSData alloc] initWithBytes:saves length:10];
    filePath = [documentsPath stringByAppendingPathComponent:@"colin.txt"];
    [data writeToFile:filePath atomically:YES];
    
    [self loadDataWithDoc];
}
- (void)loadDataWithDoc {
    // 获取沙盒里所有文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 在这里获取应用程序Documents文件夹里的文件及文件夹列表
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    // fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];

    self.dirArray = [[NSMutableArray alloc] init];
    for (NSString *file in fileList) {
        [self.dirArray addObject:file];
    }
    
    // 刷新列表, 显示数据
    [docTable reloadData];
}

/// 利用url路径打开UIDocumentInteractionController
- (void)setupDocumentControllerWithURL:(NSURL *)url {
    if (self.docInteractionController == nil) {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    } else {
        self.docInteractionController.URL = url;
    }
}
/// reader filePath
- (void)pushPDFReaderViewControllerWithFilePath:(NSString *)filePath  {
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    assert(filePath != nil); // Path to last PDF file
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
    
    if (document != nil) {
        readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        [self presentViewController:readerViewController animated:YES completion:^{
        }];
    }
}
- (void)pushGIFViewControllerWithFilePath:(NSString *)filePath {
    GIFViewController *gifViewController = [GIFViewController new];
    gifViewController.title = @"GIF";
    gifViewController.filePathString = filePath;
    [self.navigationController pushViewController:gifViewController animated:YES];
}
- (void)commonPushViewControllerWithIndex:(NSIndexPath *)indexPath {
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    previewController.dataSource = self;
    previewController.delegate = self;
    
    previewController.currentPreviewItemIndex = indexPath.row;
    [[self navigationController] pushViewController:previewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 列表操作
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellName = @"CellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSURL *fileURL= nil;
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:[self.dirArray objectAtIndex:indexPath.row]];
    fileURL = [NSURL fileURLWithPath:path];
    
    [self setupDocumentControllerWithURL:fileURL];
    cell.textLabel.text = [self.dirArray objectAtIndex:indexPath.row];
    NSInteger iconCount = [self.docInteractionController.icons count];
    if (iconCount > 0) {
        cell.imageView.image = [self.docInteractionController.icons objectAtIndex:iconCount - 1];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dirArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置拦截方法（拦截目标：PDF、GIF）
    NSIndexPath *selectedIndexPath = [docTable indexPathForSelectedRow];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:[self.dirArray objectAtIndex:selectedIndexPath.row]];
    NSString *suffixString = [path substringFromIndex:path.length - 3];
    if ([suffixString isEqualToString:@"pdf"]) {
        [self pushPDFReaderViewControllerWithFilePath:path];
        return;
    }
    if ([suffixString isEqualToString:@"gif"]) {
        [self pushGIFViewControllerWithFilePath:path];
        return;
    }
    // 通用跳转方
    [self commonPushViewControllerWithIndex:indexPath];
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController {
    return self;
}

#pragma mark - QLPreviewControllerDataSource
// Returns the number of items that the preview controller should preview
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController {
    return 1;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    // if the preview dismissed (done button touched), use this method to post-process previews
}

// returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx {
    NSURL *fileURL = nil;
    NSIndexPath *selectedIndexPath = [docTable indexPathForSelectedRow];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:[self.dirArray objectAtIndex:selectedIndexPath.row]];
    fileURL = [NSURL fileURLWithPath:path];
    
    return fileURL;
}

#pragma mark - ReaderViewControllerDelegate methods
- (void)dismissReaderViewController:(ReaderViewController *)viewController {
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    [self.navigationController popViewControllerAnimated:YES];
#else
    [self dismissViewControllerAnimated:YES completion:NULL];
#endif
}

@end
