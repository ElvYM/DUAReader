//
//  ViewController.m
//  OCReader
//
//  Created by dream duan on 2018/7/20.
//  Copyright © 2018年 dream duan. All rights reserved.
//

#import "ViewController.h"
#import "OCReader-Swift.h"

@interface ViewController () <OCReaderDelegate>
@property (nonatomic, strong) OCReader *mreader;
@property (nonatomic, strong) UIView *msettingView;

@end

@implementation ViewController

- (IBAction)onTxtClicked:(id)sender {
    self.mreader = [[OCReader alloc] init];
    OCConfigutation *configuration = [OCConfigutation new];
    configuration.backgroundImage = [UIImage imageNamed:@"backImg.jpg"];
    self.mreader.config = configuration;

    self.mreader.delegate = self;
    [self presentViewController:self.mreader animated:YES completion:nil];
    NSString *bookPath = [[NSBundle mainBundle] pathForResource:@"郭黄之恋" ofType:@"txt"];
    [self.mreader readWithFilePath:bookPath pageIndex:1];
}

- (IBAction)onEpubClicked:(id)sender {
    self.mreader = [[OCReader alloc] init];
    OCConfigutation *configuration = [OCConfigutation new];
    configuration.backgroundImage = [UIImage imageNamed:@"backImg.jpg"];
    configuration.bookType = 1;
    self.mreader.config = configuration;
    
    self.mreader.delegate = self;
    [self presentViewController:self.mreader animated:YES completion:nil];
    NSString *bookPath = [[NSBundle mainBundle] pathForResource:@"每天懂一点好玩心理学" ofType:@"epub"];
    [self.mreader readWithFilePath:bookPath pageIndex:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBaseViewClicked:(UITapGestureRecognizer *)tap
{
    UIView *topView = self.msettingView.subviews.firstObject;
    [topView removeFromSuperview];
    [self.msettingView removeFromSuperview];
}

- (void)onBackBtnClicked:(UIButton *)btn
{
    [self.mreader dismissViewControllerAnimated:YES completion:nil];
    self.mreader = nil;
    [self.msettingView removeFromSuperview];
}


- (void)readerDidClickSettingFrameWithReader:(OCReader * _Nonnull)reader {
    NSLog(@"setting view clicked");
    /*
     * 设置面板点击回调，此处可创建自定义设置面板，调节字体字号背景等各种设置
     * 详见Swift Demo
     */
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"topMenuForOC" owner:nil options:nil];
    UIView *topView = views.firstObject;
    topView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 80);
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *baseView = [[UIView alloc] initWithFrame:window.bounds];
    self.msettingView = baseView;
    [window addSubview:baseView];
    [baseView addSubview:topView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBaseViewClicked:)];
    [baseView addGestureRecognizer:tap];
    
    UIButton *back = topView.subviews.firstObject.subviews.firstObject;
    [back addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)readerWithReader:(OCReader * _Nonnull)reader chapterTitles:(NSArray<NSString *> * _Nonnull)chapterTitles {
    NSLog(@"readerWithReader chapterTitles");
    /*
     * 返回整本书目录回调
     * 详见Swift Demo
     */
}

- (void)readerWithReader:(OCReader * _Nonnull)reader readerProgressUpdated:(NSInteger)curChapter curPage:(NSInteger)curPage totalPages:(NSInteger)totalPages {
    NSLog(@"progress updated. curChapter %ld, curPage %ld", curChapter, curPage);
    /*
     * 阅读进度回调，获取阅读进度信息
     * 详见Swift Demo
     */
}

- (void)readerWithReader:(OCReader * _Nonnull)reader readerStateChanged:(NSInteger)state {
    NSLog(@"readerWithReader readerStateChanged");
    /*
     * 阅读器状态改变回调
     * 0表示繁忙，1代表就绪，可适时向用户展示loading弹框
     * 详见Swift Demo
     */
}


@end
