//
//  DropListView.h
//  DropListDemo
//
//  Created by dengweihao on 15/10/19.
//  Copyright © 2015年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropListViewDelegate <NSObject>

- (void)DropListViewDidEndEditing:(UITextField *)textField;
- (void)DropListViewBeginShow;

@end

@interface DropListView : UIView <UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate> {
    UITableView *tv;//下拉列表
    NSArray *tableArray;//下拉列表数据
    UITextField *inputTextField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}

@property (nonatomic,retain) UITableView *tv;
@property (nonatomic,retain) NSArray *tableArray;
@property (nonatomic,retain) UITextField *inputTextField;
@property (nonatomic, assign) id <DropListViewDelegate>delegate;

@end
