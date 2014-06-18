//
//  ViewController.h
//  csdnBlog
//
//  Created by Colin on 14-6-16.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"           //HUD 加载显示
#import "Colours.h"                 //颜色
#import "Reachability.h"            //Wi-Fi


@interface ViewController : UIViewController<UIAlertViewDelegate, UIWebViewDelegate, UITextFieldDelegate>
{
    //网址输入框
    UITextField *oneTF;             //单篇
    UITextField *allTF;             //整个
    UITextField *typeTF;            //专栏
    
    UISegmentedControl  *segment_;  //控制选项
    UIButton  *exportBtn;           //导出本文按钮
    
    
    UIView *firstView;              //两个对应的视图
    UIView *secondView;
    
    NSURLRequest *request;          //访问请求
    
    NSInteger now_index;            //当前访问界面编号

    int exportType;                 //导出类型

    BOOL isFirst_;                  //是否第一次进入
    
    int blogCount;                  //博客文章数目
    
    NSMutableArray *urlArr;         //每篇博客url
    
    int nowUrlNum;                  //当前博文编号
    
    UIWebView *blogWebView;         //导出博客视图
    
    UITextView *exportProgress;     //导出进度说明
    
    NSString *nowUrl;               //当前网页网址
    
    BOOL isExportOnViewOne;         //是否是第一个页面导出
}

@property (nonatomic, retain) IBOutlet UISegmentedControl  *segment_;
@property (nonatomic, retain) IBOutlet UIButton  *exportBtn;

- (IBAction)exportBtnClick:(id)sender;

@end
