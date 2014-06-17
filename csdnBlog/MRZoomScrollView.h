//
//  MRZoomScrollView.h
//  csdnBlog
//
//  Created by Colin on 14-6-16.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MRZoomScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView;
}

@property (nonatomic, retain) UIImageView *imageView;


@end
