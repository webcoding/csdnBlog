//
//  ViewController.m
//  csdnBlog
//
//  Created by Colin on 14-6-16.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize segment_;
@synthesize exportBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self performSelector:@selector(initAfterAnimation) withObject:nil afterDelay:3.5f];
}

//等待动画播放完了加载
- (void)initAfterAnimation
{
    //初始化, 导出本文按钮不可见
    self.exportBtn.hidden = true;
    
    //初始化,不是第一个页面导出
    isExportOnViewOne = false;
    
    //初始化当前访问
    now_index = 0;
    
    //初始化导出博客视图
    blogWebView = [[UIWebView alloc]init];
    
    //第一个视图初始化
    firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, Screen_height-64)];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, Screen_height-64)];
    request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.blog.csdn.net/"]];
    [webView setDelegate:self];
    [firstView addSubview: webView];
    [webView loadRequest:request];
    webView.scrollView.bounces = NO;
    [self.view addSubview:firstView];
    
    //第二个视图初始化
    secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, Screen_height-64)];
    
    //单个导出网址
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 140, 45)];
    oneLabel.text = @"...blog.csdn.net/";
    oneLabel.textAlignment = NSTextAlignmentRight;
    oneLabel.backgroundColor = [UIColor clearColor];
    [oneLabel setFont:[UIFont systemFontOfSize:14]];
    [secondView addSubview:oneLabel];
    
    //单个输入框
    oneTF = [[UITextField alloc]initWithFrame:CGRectMake(150, 20, 80, 45)];
    oneTF.borderStyle = UITextBorderStyleRoundedRect;
    oneTF.placeholder = @"详细网址";
    oneTF.font = [UIFont systemFontOfSize:14];
    oneTF.textColor = [UIColor blackColor];
    oneTF.backgroundColor = [UIColor clearColor];
    oneTF.adjustsFontSizeToFitWidth = YES;
    oneTF.returnKeyType = UIReturnKeyDone;
    oneTF.delegate = self;
    [secondView addSubview:oneTF];
    
    //单篇导出按钮
    UIButton *oneExport = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [oneExport setTitle:@"单篇导出" forState:UIControlStateNormal];
    [oneExport.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [oneExport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    oneExport.layer.borderWidth = 0;
    oneExport.layer.cornerRadius = 4.0;
    oneExport.layer.masksToBounds = YES;
    [oneExport setAdjustsImageWhenHighlighted:NO];
    oneExport.backgroundColor = [UIColor skyBlueColor];
    oneExport.autoresizingMask =UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    oneExport.frame =CGRectMake(240, 20, 70, 45);
    [oneExport addTarget:self action:@selector(oneExportBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:oneExport];
    
    //全部导出网址
    UILabel *allLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 140, 45)];
    allLabel.text = @"...blog.csdn.net/";
    allLabel.textAlignment = NSTextAlignmentRight;
    allLabel.backgroundColor = [UIColor clearColor];
    [allLabel setFont:[UIFont systemFontOfSize:14]];
    [secondView addSubview:allLabel];
    
    //全部输入框
    allTF = [[UITextField alloc]initWithFrame:CGRectMake(150, 90, 80, 45)];
    allTF.borderStyle = UITextBorderStyleRoundedRect;
    allTF.placeholder = @"博主ID";
    allTF.font = [UIFont systemFontOfSize:14];
    allTF.textColor = [UIColor blackColor];
    allTF.backgroundColor = [UIColor clearColor];
    allTF.adjustsFontSizeToFitWidth = YES;
    allTF.returnKeyType = UIReturnKeyDone;
    allTF.delegate = self;
    [secondView addSubview:allTF];
    
    //全部导出按钮
    UIButton *allExport = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [allExport setTitle:@"全部导出" forState:UIControlStateNormal];
    [allExport.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [allExport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allExport.layer.borderWidth = 0;
    allExport.layer.cornerRadius = 4.0;
    allExport.layer.masksToBounds = YES;
    [allExport setAdjustsImageWhenHighlighted:NO];
    allExport.backgroundColor = [UIColor pinkLipstickColor];
    allExport.autoresizingMask =UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    allExport.frame =CGRectMake(240, 90, 70, 45);
    [allExport addTarget:self action:@selector(allExportBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:allExport];
    
    
    //专栏导出网址
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, 140, 45)];
    typeLabel.text = @"...net/column/details/";
    typeLabel.textAlignment = NSTextAlignmentRight;
    typeLabel.backgroundColor = [UIColor clearColor];
    [typeLabel setFont:[UIFont systemFontOfSize:14]];
    [secondView addSubview:typeLabel];
    
    //专栏输入框
    typeTF = [[UITextField alloc]initWithFrame:CGRectMake(150, 160, 80, 45)];
    typeTF.borderStyle = UITextBorderStyleRoundedRect;
    typeTF.placeholder = @"专栏ID";
    typeTF.font = [UIFont systemFontOfSize:14];
    typeTF.textColor = [UIColor blackColor];
    typeTF.backgroundColor = [UIColor clearColor];
    typeTF.adjustsFontSizeToFitWidth = YES;
    typeTF.returnKeyType = UIReturnKeyDone;
    typeTF.delegate = self;
    [secondView addSubview:typeTF];
    
    //专栏导出按钮
    UIButton *typeExport = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [typeExport setTitle:@"专栏导出" forState:UIControlStateNormal];
    [typeExport.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [typeExport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    typeExport.layer.borderWidth = 0;
    typeExport.layer.cornerRadius = 4.0;
    typeExport.layer.masksToBounds = YES;
    [typeExport setAdjustsImageWhenHighlighted:NO];
    typeExport.backgroundColor = [UIColor successColor];
    typeExport.autoresizingMask =UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    typeExport.frame =CGRectMake(240, 160, 70, 45);
    [typeExport addTarget:self action:@selector(typeExportBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:typeExport];
    
    
    //导出进度说明框
    exportProgress = [[UITextView alloc]initWithFrame:CGRectMake(10, 240, 300, Screen_height-64-250)];
    exportProgress.editable = NO;
    exportProgress.font = [UIFont systemFontOfSize:15];
    exportProgress.text = @"选择要导出的类型, 填写相应信息";
    [secondView addSubview:exportProgress];
    
    
    //为segment_绑定监听
    [segment_ addTarget:self action:@selector(viewReload:) forControlEvents:UIControlEventValueChanged];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - btnClick

//单篇导出
-(void)oneExportBtnClick:(id)sender
{
    //隐藏键盘
    [allTF resignFirstResponder];
    [oneTF resignFirstResponder];
    [typeTF resignFirstResponder];
    
    exportType = 0;
    
    if (oneTF.text.length == 0)
    {
        UIAlertView *alert_ = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确博客网址" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:Nil, nil];
        [alert_ show];
        return;
    }
    
    //判断是否是Wi-Fi环境。 
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWiFi)
    {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/%@", oneTF.text]]];
        [blogWebView setDelegate:self];
        [blogWebView loadRequest:request];
    }
    else
    {
        UIAlertView *alert_ = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未打开Wi-Fi,是否继续导出?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert_.tag = 10;
        [alert_ show];
        return;
    }
}

//全部导出
-(void)allExportBtnClick:(id)sender
{
    //隐藏键盘
    [allTF resignFirstResponder];
    [oneTF resignFirstResponder];
    [typeTF resignFirstResponder];
    
    exportType = 1;
    
    if (allTF.text.length == 0)
    {
        UIAlertView *alert_ = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的博主ID" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:Nil, nil];
        [alert_ show];
        return;
    }
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWiFi)
    {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/%@?viewmode=contents", allTF.text]]];
        [blogWebView setDelegate:self];
        [blogWebView loadRequest:request];
        
        isFirst_ = true;
        blogCount = 0;
        nowUrlNum = 0;
        urlArr = [[NSMutableArray alloc]init];
    }
    else
    {
        UIAlertView *alert_ = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未打开Wi-Fi,是否继续导出?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert_.tag = 11;
        [alert_ show];
        return;
    }
    
    
}

//AlertView已经消失时执行的事件
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //判断是否是Wi-Fi警告
    if (alertView.tag == 11)
    {
        if (buttonIndex == 0)
        {
            request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/%@?viewmode=contents", allTF.text]]];
            [blogWebView setDelegate:self];
            [blogWebView loadRequest:request];
            
            isFirst_ = true;
            blogCount = 0;
            nowUrlNum = 0;
            urlArr = [[NSMutableArray alloc]init];
        }
    }
    
    //判断是否是Wi-Fi警告
    if (alertView.tag == 10)
    {
        if (buttonIndex == 0)
        {
            request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/%@", oneTF.text]]];
            [blogWebView setDelegate:self];
            [blogWebView loadRequest:request];
        }
    }
    
    //判断是否是Wi-Fi警告
    if (alertView.tag == 12)
    {
        if (buttonIndex == 0)
        {
            request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/column/details/%@.html", typeTF.text]]];
            [blogWebView setDelegate:self];
            [blogWebView loadRequest:request];
            
            isFirst_ = true;
            blogCount = 0;
            nowUrlNum = 0;
            urlArr = [[NSMutableArray alloc]init];
        }
    }
}

//专栏导出
-(void)typeExportBtnClick:(id)sender
{
    //隐藏键盘
    [allTF resignFirstResponder];
    [oneTF resignFirstResponder];
    [typeTF resignFirstResponder];
    
    exportType = 2;
    
    if (typeTF.text.length == 0)
    {
        UIAlertView *alert_ = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确专栏ID" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:Nil, nil];
        [alert_ show];
        return;
    }
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWiFi)
    {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/column/details/%@.html", typeTF.text]]];
        [blogWebView setDelegate:self];
        [blogWebView loadRequest:request];
        
        isFirst_ = true;
        blogCount = 0;
        nowUrlNum = 0;
        urlArr = [[NSMutableArray alloc]init];
    }
    else
    {
        UIAlertView *alert_ = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未打开Wi-Fi,是否继续导出?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert_.tag = 12;
        [alert_ show];
        return;
    }
}


#pragma mark - 导出浏览器文章
- (IBAction)exportBtnClick:(id)sender
{
    //判断是否可以导出
    if ([nowUrl rangeOfString:@"blog.csdn.net/blog/"].location !=NSNotFound)
    {
        NSArray *eachLines = [nowUrl componentsSeparatedByString:@"/"];
    
        //单篇导出或者专栏导出
        if ([eachLines count] == 6)
        {
            //专栏导出
            if ([nowUrl rangeOfString:@"blog.csdn.net/Column/"].location !=NSNotFound)
            {
                NSLog(@"专栏");
                isExportOnViewOne = true;
                exportType = 2;
                request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/column/details/%@.html", [eachLines objectAtIndex:5]]]];
                [blogWebView setDelegate:self];
                [blogWebView loadRequest:request];
                
                isFirst_ = true;
                blogCount = 0;
                nowUrlNum = 0;
                urlArr = [[NSMutableArray alloc]init];
            }
            else
            {
                isExportOnViewOne = true;
                exportType = 0;
                request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/%@/article/details/%@", [eachLines objectAtIndex:4], [eachLines objectAtIndex:5]]]];
                [blogWebView setDelegate:self];
                [blogWebView loadRequest:request];
            }
        }
        else if ([eachLines count] == 5)    //全部导出
        {
            isExportOnViewOne = true;
            exportType = 1;
            request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/%@?viewmode=contents", [eachLines objectAtIndex:4]]]];
            [blogWebView setDelegate:self];
            [blogWebView loadRequest:request];
            
            isFirst_ = true;
            blogCount = 0;
            nowUrlNum = 0;
            urlArr = [[NSMutableArray alloc]init];
        }
    }
}

#pragma mark - webView
//网页加载错误的时候调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}

//网页加载完成的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //防止重复访问一个网页
    if ([nowUrl isEqualToString:[webView stringByEvaluatingJavaScriptFromString:@"document.location.href"]])
    {
        [SVProgressHUD dismiss];
        return;
    }
    else
    {
        nowUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
        NSLog(@"%@", nowUrl);
        NSArray *eachLines = [nowUrl componentsSeparatedByString:@"/"];

        NSLog(@"%@",eachLines);
    }
    
    
    //判断是否可以导出
    if ([nowUrl rangeOfString:@"blog.csdn.net/blog/"].location !=NSNotFound || [nowUrl rangeOfString:@"blog.csdn.net/Column/"].location !=NSNotFound )
    {
        self.exportBtn.hidden = false;
    }
    else
    {
        self.exportBtn.hidden = true;
    }
    
    if (now_index == 0 && !isExportOnViewOne)
    {
        [SVProgressHUD dismiss];
    }
    else if (now_index == 1 || isExportOnViewOne)
    {
        //单篇导出
        if (exportType == 0)
        {
            isExportOnViewOne = false;
            //获取详细内容
            NSString *lJs = @"document.getElementById(\"article_content\").innerHTML";
            //获取标题
            NSString *lJs2 = @"document.getElementById(\"article_details\").getElementsByClassName(\"article_title\")[0].getElementsByTagName(\"a\")[0].innerText";
            NSString *lHtml1 = [webView stringByEvaluatingJavaScriptFromString:lJs];
            NSString *lHtml2 = [webView stringByEvaluatingJavaScriptFromString:lJs2];
            
            //获取完整路径 以及字典和数组的初始化
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"csdnInfo.plist"];
            NSMutableArray *blogArr = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
            
            for (int i=0; i<[blogArr count]; i++)
            {
                //判断是否存在
                if ([[[blogArr objectAtIndex:i]objectForKey:@"name"]isEqualToString:lHtml2])
                {
                    exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n %@ 已存在。无需导出",[NSDate date],lHtml2]];
                    //滚动到末尾
                    [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                    [SVProgressHUD dismiss];
                    return;
                }
            }
            
            exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n正在导出:  %@",[NSDate date],lHtml2]];
            //滚动到末尾
            [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
            
            //修改图片大小
            if ([lHtml1 rangeOfString:@"<img"].location != NSNotFound)
            {
                NSScanner *myScanner = [NSScanner scannerWithString:lHtml1];
                NSString *myText = nil;
                while ([myScanner isAtEnd] == NO)
                {
                    [myScanner scanUpToString:@"<img" intoString:nil];
                    [myScanner scanUpToString:@"s" intoString:&myText];
                    
                    lHtml1 = [lHtml1 stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@s",myText] withString:@"<img style=\"width:300px;height:this.offsetHeight;\" s"];
                }
            }
            
            //缓存图片, 并修改图片Url
            if ([lHtml1 rangeOfString:@"<img"].location != NSNotFound)
            {
                NSScanner *myScanner = [NSScanner scannerWithString:lHtml1];
                NSString *myText = nil;
                int imageNum = 0;
                while ([myScanner isAtEnd] == NO)
                {
                    [myScanner scanUpToString:@"http://img.blog.csdn.net" intoString:nil];
                    [myScanner scanUpToString:@"\"" intoString:&myText];
                    
                    NSURL *myUrl = [NSURL URLWithString:myText];
                    UIImage *myImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:myUrl]];
                    
                    //Document
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                    /*写入图片*/
                    //帮文件起个名
                    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_%@.png", imageNum, [NSDate date]]];
                    //将图片写到Documents文件中
                    [UIImagePNGRepresentation(myImage)writeToFile: uniquePath    atomically:YES];
                    
                    imageNum++;
                    
                    lHtml1 = [lHtml1 stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",myText] withString:uniquePath];
                    
                }
            }
            
            
            NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
            
            [info setObject:lHtml1 forKey:@"info"];
            [info setObject:lHtml2 forKey:@"name"];
            [blogArr addObject:info];
            
            if (blogArr == NULL)
            {
                blogArr = [[NSMutableArray alloc]initWithObjects:info, nil];
            }
            
            [blogArr writeToFile:namePath atomically:YES];
            
            exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n导出成功",[NSDate date]]];
            //滚动到末尾
            [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
            [SVProgressHUD dismiss];
            
        }
        else if (exportType == 1)
        {
            //第一次进入:获取各个文章url   第二次进入:逐个获取
            if (isFirst_)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
                //获取博客数目
                NSString *bLength = @"document.getElementsByClassName(\"list_item list_view\").length";
                blogCount = [[webView stringByEvaluatingJavaScriptFromString:bLength]intValue];
                
                //输入的网址错误或者文章数量为0
                if (blogCount == 0)
                {
                    [SVProgressHUD dismiss];
                    
                    exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n输入的网址错误或者文章数量为0,导出失败",[NSDate date]]];
                    //滚动到末尾
                    [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                    
                    return;
                }
                
                //修改, 不是第一次进入
                isFirst_ = false;
                
                exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n获取列表成功,共%d篇文章.开始导出...",[NSDate date], blogCount]];
                //滚动到末尾
                [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                
                //把url写入数组
                for (int i=0; i<blogCount; i++)
                {
                    NSString *nowUrl = [NSString stringWithFormat:@"document.getElementsByClassName(\"list_item list_view\")[%d].getElementsByTagName(\"a\")[0].href", i];
                    [urlArr addObject:[webView stringByEvaluatingJavaScriptFromString:nowUrl]];
                }
                
                
                //开始访问
                request =[NSURLRequest requestWithURL:[NSURL URLWithString:[urlArr objectAtIndex:nowUrlNum]]];
                [blogWebView setDelegate:self];
                [blogWebView loadRequest:request];
                nowUrlNum++;
            }
            else
            {
                if (nowUrlNum > blogCount + 1)
                {
                    [SVProgressHUD dismiss];
                    isExportOnViewOne = false;
                    return;
                }
                if (nowUrlNum == blogCount + 1)
                {
                    [SVProgressHUD dismiss];
                    isExportOnViewOne = false;
                    exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n恭喜成功导出 %d 篇文章",[NSDate date], blogCount]];
                    //滚动到末尾
                    [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                    nowUrlNum++;
                    return;
                }
                //获取详细内容
                NSString *lJs = @"document.getElementById(\"article_content\").innerHTML";
                //获取标题
                NSString *lJs2 = @"document.getElementById(\"article_details\").getElementsByClassName(\"article_title\")[0].getElementsByTagName(\"a\")[0].innerText";
                NSString *lHtml1 = [webView stringByEvaluatingJavaScriptFromString:lJs];
                NSString *lHtml2 = [webView stringByEvaluatingJavaScriptFromString:lJs2];
                
                //获取完整路径 以及字典和数组的初始化
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"csdnInfo.plist"];
                NSMutableArray *blogArr = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
                
                for (int i=0; i<[blogArr count]; i++)
                {
                    //判断是否存在
                    if ([[[blogArr objectAtIndex:i]objectForKey:@"name"]isEqualToString:lHtml2])
                    {
                        exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n %@ 已存在。无需导出",[NSDate date],lHtml2]];
                        //滚动到末尾
                        [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                        return;
                    }
                }
                
                exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n正在导出:(%d/%d)  %@",[NSDate date], nowUrlNum,blogCount,lHtml2]];
                //滚动到末尾
                [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                
                //修改图片大小
                if ([lHtml1 rangeOfString:@"<img"].location != NSNotFound)
                {
                    NSScanner *myScanner = [NSScanner scannerWithString:lHtml1];
                    NSString *myText = nil;
                    while ([myScanner isAtEnd] == NO)
                    {
                        [myScanner scanUpToString:@"<img" intoString:nil];
                        [myScanner scanUpToString:@"s" intoString:&myText];
                        
                        lHtml1 = [lHtml1 stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@s",myText] withString:@"<img style=\"width:300px;height:this.offsetHeight;\" s"];
                    }
                }
                
                //缓存图片, 并修改图片Url
                if ([lHtml1 rangeOfString:@"<img"].location != NSNotFound)
                {
                    NSScanner *myScanner = [NSScanner scannerWithString:lHtml1];
                    NSString *myText = nil;
                    int imageNum = 0;
                    while ([myScanner isAtEnd] == NO)
                    {
                        [myScanner scanUpToString:@"http://img.blog.csdn.net" intoString:nil];
                        [myScanner scanUpToString:@"\"" intoString:&myText];
                        //                NSLog(@"%@",myText);
                        
                        NSURL *myUrl = [NSURL URLWithString:myText];
                        UIImage *myImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:myUrl]];
                        
                        //Document
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                        /*写入图片*/
                        //帮文件起个名
                        NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_%@.png", imageNum, [NSDate date]]];
                        //将图片写到Documents文件中
                        [UIImagePNGRepresentation(myImage)writeToFile: uniquePath    atomically:YES];
                        
                        //                NSLog(@"%@", uniquePath);
                        imageNum++;
                        
                        lHtml1 = [lHtml1 stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",myText] withString:uniquePath];
                        
                    }
                }
                
                
                NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
                
                [info setObject:lHtml1 forKey:@"info"];
                [info setObject:lHtml2 forKey:@"name"];
                [blogArr addObject:info];
                
                if (blogArr == NULL)
                {
                    blogArr = [[NSMutableArray alloc]initWithObjects:info, nil];
                }
                
                [blogArr writeToFile:namePath atomically:YES];
                
                
                //开始访问
                request =[NSURLRequest requestWithURL:[NSURL URLWithString:[urlArr objectAtIndex:nowUrlNum]]];
                [blogWebView setDelegate:self];
                [blogWebView loadRequest:request];
                nowUrlNum++;
                
                
            }
        }
        else if (exportType == 2)
        {
            //第一次进入:获取各个文章url   第二次进入:逐个获取
            if (isFirst_)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
                //获取博客数目
                NSString *bLength = @"document.getElementsByClassName(\"blog_list\").length";
                blogCount = [[webView stringByEvaluatingJavaScriptFromString:bLength]intValue];
                
                NSLog(@"%d", blogCount);
                //输入的网址错误或者文章数量为0
                if (blogCount == 0)
                {
                    [SVProgressHUD dismiss];
                    
                    exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n输入的网址错误或者文章数量为0,导出失败",[NSDate date]]];
                    //滚动到末尾
                    [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                    
                    return;
                }
                
                //修改, 不是第一次进入
                isFirst_ = false;
                
                exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n获取列表成功,共%d篇文章.开始导出...",[NSDate date], blogCount]];
                //滚动到末尾
                [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                
                //把url写入数组
                for (int i=0; i<blogCount; i++)
                {
                    NSString *nowUrl = [NSString stringWithFormat:@"document.getElementsByClassName(\"blog_list\")[%d].getElementsByTagName(\"a\")[1].href", i];
                    [urlArr addObject:[webView stringByEvaluatingJavaScriptFromString:nowUrl]];
                }
                
                
                //开始访问
                request =[NSURLRequest requestWithURL:[NSURL URLWithString:[urlArr objectAtIndex:nowUrlNum]]];
                [blogWebView setDelegate:self];
                [blogWebView loadRequest:request];
                nowUrlNum++;
            }
            else
            {
                if (nowUrlNum > blogCount + 1)
                {
                    [SVProgressHUD dismiss];
                    isExportOnViewOne = false;
                    return;
                }
                if (nowUrlNum == blogCount + 1)
                {
                    [SVProgressHUD dismiss];
                    isExportOnViewOne = false;
                    
                    UIAlertView *errAlert_ = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"恭喜成功导出 %d 篇文章", blogCount] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:Nil, nil];
                    [errAlert_ show];
                    
                    exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n恭喜成功导出 %d 篇文章",[NSDate date], blogCount]];
                    //滚动到末尾
                    [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                    nowUrlNum++;
                    return;
                }
                //获取详细内容
                NSString *lJs = @"document.getElementById(\"article_content\").innerHTML";
                //获取标题
                NSString *lJs2 = @"document.getElementById(\"article_details\").getElementsByClassName(\"article_title\")[0].getElementsByTagName(\"a\")[0].innerText";
                NSString *lHtml1 = [webView stringByEvaluatingJavaScriptFromString:lJs];
                NSString *lHtml2 = [webView stringByEvaluatingJavaScriptFromString:lJs2];
                
                //获取完整路径 以及字典和数组的初始化
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"csdnInfo.plist"];
                NSMutableArray *blogArr = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
                
                for (int i=0; i<[blogArr count]; i++)
                {
                    //判断是否存在
                    if ([[[blogArr objectAtIndex:i]objectForKey:@"name"]isEqualToString:lHtml2])
                    {
                        exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n %@ 已存在。无需导出",[NSDate date],lHtml2]];
                        //滚动到末尾
                        [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                        [SVProgressHUD dismiss];
                        return;
                    }
                }
                
                exportProgress.text = [exportProgress.text stringByAppendingString:[NSString stringWithFormat:@"\n====%@====\n正在导出:(%d/%d)  %@",[NSDate date], nowUrlNum,blogCount,lHtml2]];
                //滚动到末尾
                [exportProgress scrollRangeToVisible:NSMakeRange([exportProgress.text length]-1,0)];
                
                //修改图片大小
                if ([lHtml1 rangeOfString:@"<img"].location != NSNotFound)
                {
                    NSScanner *myScanner = [NSScanner scannerWithString:lHtml1];
                    NSString *myText = nil;
                    while ([myScanner isAtEnd] == NO)
                    {
                        [myScanner scanUpToString:@"<img" intoString:nil];
                        [myScanner scanUpToString:@"s" intoString:&myText];
                        
                        lHtml1 = [lHtml1 stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@s",myText] withString:@"<img style=\"width:300px;height:this.offsetHeight;\" s"];
                    }
                }
                
                //缓存图片, 并修改图片Url
                if ([lHtml1 rangeOfString:@"<img"].location != NSNotFound)
                {
                    NSScanner *myScanner = [NSScanner scannerWithString:lHtml1];
                    NSString *myText = nil;
                    int imageNum = 0;
                    while ([myScanner isAtEnd] == NO)
                    {
                        [myScanner scanUpToString:@"http://img.blog.csdn.net" intoString:nil];
                        [myScanner scanUpToString:@"\"" intoString:&myText];
                        //                NSLog(@"%@",myText);
                        
                        NSURL *myUrl = [NSURL URLWithString:myText];
                        UIImage *myImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:myUrl]];
                        
                        //Document
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                        /*写入图片*/
                        //帮文件起个名
                        NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_%@.png", imageNum, [NSDate date]]];
                        //将图片写到Documents文件中
                        [UIImagePNGRepresentation(myImage)writeToFile: uniquePath    atomically:YES];
                        
                        //                NSLog(@"%@", uniquePath);
                        imageNum++;
                        
                        lHtml1 = [lHtml1 stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",myText] withString:uniquePath];
                        
                    }
                }
                
                
                NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
                
                [info setObject:lHtml1 forKey:@"info"];
                [info setObject:lHtml2 forKey:@"name"];
                [blogArr addObject:info];
                
                if (blogArr == NULL)
                {
                    blogArr = [[NSMutableArray alloc]initWithObjects:info, nil];
                }
                
                [blogArr writeToFile:namePath atomically:YES];
                
                //开始访问
                request =[NSURLRequest requestWithURL:[NSURL URLWithString:[urlArr objectAtIndex:nowUrlNum]]];
                [blogWebView setDelegate:self];
                [blogWebView loadRequest:request];
                nowUrlNum++;
                
                
            }
        }
        
    }
    
}

//网页开始加载的时候调用
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
}

#pragma mark - 响应segment_切换
//响应segment_切换。    改变视图，重新载入
-(void)viewReload:(id)sender
{
    now_index = [segment_ selectedSegmentIndex];
    if (now_index == 0)
    {
        [secondView removeFromSuperview];
        [self.view addSubview:firstView];
    }
    if (now_index == 1)
    {
        [firstView removeFromSuperview];
        [self.view addSubview:secondView];
    }
}


@end
