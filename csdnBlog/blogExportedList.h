//
//  blogExportedList.h
//  csdnBlog
//
//  Created by Colin on 14-6-16.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import <UIKit/UIKit.h>

//查询子列表
#import "DDList.h"
#import "PassValueDelegate.h"

//详细视图
#import "blogExportedDetail.h"



@interface blogExportedList : UIViewController<UISearchBarDelegate, PassValueDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *blogArr;
    
    IBOutlet UISearchBar *_searchBar;    //搜索bar
    DDList				 *_ddList;       //提示列表
	NSString			 *_searchStr;    //输入的搜索字符串
    NSMutableArray	*nameList;           //姓名数组

}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (void)setDDListHidden:(BOOL)hidden;    //隐藏提示视图


@end
