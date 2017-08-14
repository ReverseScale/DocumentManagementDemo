//
//  DocTableViewController.h
//  ReaderPDFDemo
//
//  Created by WhatsXie on 2017/8/14.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface DocTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate,UIDocumentInteractionControllerDelegate>{
    //step3. 声明显示列表
    IBOutlet UITableView *docTable;
}

@property(nonatomic,retain) NSMutableArray *dirArray;
@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;
@end
