//
//  DDList.h
//  DropDownList
//
//  Created by kingyee on 11-9-19.
//  Copyright 2011 Kingyee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassValueDelegate;

@interface DDList : UITableViewController {
	NSString		*_searchText;
	NSString		*_selectedText;
	NSMutableArray	*_resultList;
    NSMutableArray	*_totalList;
	id <PassValueDelegate>	_delegate;
}

@property (nonatomic, copy)NSString		*_searchText;
@property (nonatomic, copy)NSString		*_selectedText;
@property (nonatomic, retain)NSMutableArray	*_resultList;
@property (nonatomic, retain)NSMutableArray	*_totalList;

@property (assign) id <PassValueDelegate> _delegate;

- (void)updateData;

@end
