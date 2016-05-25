//
//  DropListView.m
//  DropListDemo
//
//  Created by dengweihao on 15/10/19.
//  Copyright © 2015年 vcyber. All rights reserved.
//

#import "DropListView.h"

@implementation DropListView

@synthesize tv,tableArray,inputTextField;

- (instancetype)initWithFrame:(CGRect)frame
{
    tabheight = 0.0f;
    frameHeight = 30.0f;
    
    frame.size.height = frameHeight;
    
    self = [super initWithFrame:frame];
    
    if(self) {
        showList = NO;
        
        inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        inputTextField.borderStyle = UITextBorderStyleRoundedRect;
        [inputTextField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:inputTextField];
        inputTextField.delegate = self;
        
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 0)];
        tv.delegate = self;
        tv.dataSource = self;
        tv.backgroundColor = [UIColor grayColor];
        tv.separatorColor = [UIColor lightGrayColor];
        tv.hidden = YES;
        [self addSubview:tv];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)dropdown {
//    NSLog(@"dropdown");
    if (showList) {
        [self hideTableView];
    }else {
        [self showTableView];
    }
}

- (void)showTableView {
    [self.superview bringSubviewToFront:self];
    tv.hidden = NO;
    showList = YES;
    
    if ([self.delegate respondsToSelector:@selector(DropListViewBeginShow)]) {
        [self.delegate DropListViewBeginShow];
        [tv reloadData];
    }
//    NSLog(@"showTableView--%lu", tableArray.count);
    
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    
    frameHeight = tableArray.count*35+30;
    tabheight = tableArray.count*35;
    
    frame.size.height = tabheight;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    CGRect sf = self.frame;
    sf.size.height = frameHeight;
    
    self.frame = sf;
    
    tv.frame = frame;
    [UIView commitAnimations];
}

- (void)hideTableView {
    showList = NO;
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
//    NSLog(@"hideTableView");
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.backgroundColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    inputTextField.text = [tableArray objectAtIndex:[indexPath row]];
    
    [self hideTableView];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.inputTextField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (showList) {
        [self hideTableView];
    }
    if ([self.delegate respondsToSelector:@selector(DropListViewDidEndEditing:)]) {
        [self.delegate DropListViewDidEndEditing:textField];
    }
}

#pragma mark - ohter

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
