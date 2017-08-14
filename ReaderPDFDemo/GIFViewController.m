//
//  GIFViewController.m
//  ReaderPDFDemo
//
//  Created by WhatsXie on 2017/8/14.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import "GIFViewController.h"
#import "YLGIFPlayer.h"
#import "PraseGIFViewController.h"
#import "PraseGIFDataToImageArrayTools.h"

@interface GIFViewController ()

@end

@implementation GIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupGIF];
    [self addRightBtn];
}
- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"切片" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedPrase)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedPrase {
    NSData *gifData = [NSData dataWithContentsOfFile:self.filePathString];
    NSMutableArray *praseGif = [PraseGIFDataToImageArrayTools praseGIFDataToImageArray:gifData];
    
    PraseGIFViewController *praseGifVC = [PraseGIFViewController new];
    praseGifVC.praseGIFMutableArray = praseGif;
    praseGifVC.title = @"Prase";
    [self.navigationController pushViewController:praseGifVC animated:YES];
}

- (void)setupGIF {
    YLImageView* imageView = [[YLImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 3 * 2, self.view.frame.size.height / 3 * 2)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    imageView.image = [YLGIFImage imageWithContentsOfFile:self.filePathString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
