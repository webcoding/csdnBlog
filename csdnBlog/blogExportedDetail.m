//
//  blogExportedDetail.m
//  csdnBlog
//
//  Created by Colin on 14-6-16.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "blogExportedDetail.h"
#import "UIImageView+WebCache.h"

@interface blogExportedDetail ()<UIGestureRecognizerDelegate>

@property (nonatomic,retain) UIWebView *myWeb;

@end

@implementation blogExportedDetail
@synthesize nameStr;
@synthesize infoStr;
@synthesize myWeb;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 320, 50)];
    titleLabel.text = nameStr;
    //设置文本在label中显示的位置，这里为居中。
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont boldSystemFontOfSize:23];
    titleLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    
    UILabel *apartLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 114, 330, 5)];
    apartLine.text = @"-------------------------------------------------------------";
    //设置文本在label中显示的位置，这里为居z中。
    apartLine.textAlignment = NSTextAlignmentRight;
    apartLine.font = [UIFont systemFontOfSize:15];
    apartLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:apartLine];
    
    myWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 120, 320, Screen_height-120)];
    //利用本地url打开图片
    NSString *resPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/"];
    [myWeb loadHTMLString:infoStr
                        baseURL:[NSURL fileURLWithPath:resPath]];
    //不可上下拉动
    myWeb.scrollView.bounces = NO;
    
    [self.view addSubview:myWeb];
    
    [self addTapOnWebView];


}

-(void)addTapOnWebView
{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.myWeb addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
}

#pragma mark- TapGestureRecognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    CGPoint pt = [sender locationInView:self.myWeb];
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
    NSString *urlToSave = [self.myWeb stringByEvaluatingJavaScriptFromString:imgURL];
    NSString *imgWidth = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).height", pt.x, pt.y];
    NSLog(@"%@",NSHomeDirectory());
    if (urlToSave.length > 0)
    {
        [self showImageURL:urlToSave point:pt heigth:[[self.myWeb stringByEvaluatingJavaScriptFromString:imgWidth] floatValue]];
    }
}

//呈现图片
-(void)showImageURL:(NSString *)url point:(CGPoint)point heigth:(float)heigth_
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, Screen_height-64)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor blackColor];
    [scrollView setContentSize:CGSizeMake(320 * 3, Screen_height-64)];

    
    
    MRZoomScrollView *_zoomScrollView = [[MRZoomScrollView alloc]init];
    _zoomScrollView.frame = CGRectMake(0, 0, 320, Screen_height-64);
    CGRect frame = CGRectMake(10, 0, 300, heigth_);
    [_zoomScrollView.imageView setImageWithURL:[NSURL URLWithString:url]];
    _zoomScrollView.imageView.frame = frame;
    
    [scrollView addSubview:_zoomScrollView];
    
    //添加点击去掉图片
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleViewTap:)];
    [_zoomScrollView addGestureRecognizer:singleTap];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


//移除图片查看视图
-(void)handleSingleViewTap:(UITapGestureRecognizer *)sender
{
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [obj removeFromSuperview];
        }
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
