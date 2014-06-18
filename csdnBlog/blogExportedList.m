//
//  blogExportedList.m
//  csdnBlog
//
//  Created by Colin on 14-6-16.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "blogExportedList.h"

@interface blogExportedList ()

@end

@implementation blogExportedList
@synthesize myTableView;

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
    
    //设置 navigationItem 标题
    self.navigationItem.title = @"已导列表";
    
    if (Screen_height < 568)
    {
        self.myTableView.frame = CGRectMake(0, 108, 320, Screen_height-108);
    }
    
    //获取完整路径 以及字典和数组的初始化
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"csdnInfo.plist"];
    
    //获取导出的对应数据
    blogArr = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
    
    //查询列表初始化
    nameList = [[NSMutableArray alloc]init];
    for (int i =0; i<[blogArr count]; i++)
    {
        [nameList addObject:[[blogArr objectAtIndex:i]objectForKey:@"name"]];
    }
    
    //初始化查询的字符串
	_searchStr = @"";
	
    //初始化提醒视图
	_ddList = [[DDList alloc] initWithStyle:UITableViewStylePlain];
	_ddList._delegate = self;
	[self.view addSubview:_ddList.view];
	[_ddList.view setFrame:CGRectMake(30, 108, 200, 0)];
    _ddList._totalList = nameList;

	// Do any additional setup after loading the view.
}


//隐藏提醒视图
- (void)setDDListHidden:(BOOL)hidden
{
	NSInteger height = hidden ? 0 : 180;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.2];
	[_ddList.view setFrame:CGRectMake(30, 108, 200, height)];
	[UIView commitAnimations];
}

//单例,传回选中提醒框中的结果
#pragma mark -
#pragma mark 传回数据
- (void)passValue:(NSString *)value
{
    //如果有选中，则修改当前搜索内容为返回结果,调用结束函数searchBarSearchButtonClicked
	if (value)
    {
		_searchBar.text = value;
		[self searchBarSearchButtonClicked:_searchBar];
	}
	else {
		
	}
}

//搜索框中的字符改变时候调用
#pragma mark -
#pragma mark SearchBar Delegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //如果搜索框有内容,更新提示列表
	if ([searchText length] != 0) {
		_ddList._searchText = searchText;
		[_ddList updateData];
		[self setDDListHidden:NO];
	}
	else
    {
		[self setDDListHidden:YES];  //否则隐藏
	}
    
}

//文本框弹出，开始搜索
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
	searchBar.showsCancelButton = YES;
	for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
	return YES;
}

//开始搜索响应。
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	searchBar.text = @"";
}

//结束文本框输入
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	searchBar.showsCancelButton = NO;
	searchBar.text = @"";
}

//当选中了提示列表中的某个,搜索结束，选中结果，并且高亮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self setDDListHidden:YES];  //隐藏提示视图
	_searchStr = [searchBar text]; //获得查询结果
	[searchBar resignFirstResponder];  //收回键盘
    
    for (int i = 0; i<[blogArr count]; i++)  //从列表中查找结果，选中
    {
        if ([[[blogArr objectAtIndex:i]objectForKey:@"name"] isEqualToString:_searchStr])
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [myTableView reloadData];
            [myTableView scrollToRowAtIndexPath:indexPath     //滚动视图
                              atScrollPosition:UITableViewScrollPositionMiddle
                                      animated:YES];
            [myTableView selectRowAtIndexPath:indexPath       //选中高亮
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
    
    
}

//取消搜索响应
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[self setDDListHidden:YES];
	[searchBar resignFirstResponder];
}



#pragma mark -
#pragma mark UITableView Datasource

//每个cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

//header高度 iOS7默认有高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

//section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//每个section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [blogArr count];
}

//点击cell响应
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"blogDetailSegue" sender:self];
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[blogArr objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

//删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //获取完整路径 以及字典和数组的初始化
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"csdnInfo.plist"];
        
        [blogArr removeObjectAtIndex:indexPath.row];
        
        [blogArr writeToFile:namePath atomically:YES];
        
        [nameList removeObjectAtIndex:indexPath.row];
        
        [myTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}

//segue传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"blogDetailSegue"])
    {
        NSIndexPath *indexPath = [myTableView indexPathForSelectedRow];
        blogExportedDetail *destViewController = segue.destinationViewController;
        destViewController.nameStr = [[blogArr objectAtIndex:indexPath.row] objectForKey:@"name"];
        destViewController.infoStr = [[blogArr objectAtIndex:indexPath.row] objectForKey:@"info"];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
