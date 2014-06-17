//
//  blogExportedDetail.h
//  csdnBlog
//
//  Created by Colin on 14-6-16.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"  //图片缩略


@interface blogExportedDetail : UIViewController<UIScrollViewDelegate>

@property(weak, nonatomic) NSString *nameStr;
@property(weak, nonatomic) NSString *infoStr;


@end
