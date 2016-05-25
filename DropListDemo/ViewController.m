//
//  ViewController.m
//  DropListDemo
//
//  Created by dengweihao on 15/10/19.
//  Copyright © 2015年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "DropListView.h"

#define documentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]

#define newFielPath [documentsPath stringByAppendingPathComponent:@"aa.plist"]

@interface ViewController ()<DropListViewDelegate>

@property (nonatomic, strong) DropListView *dd1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dd1 = [[DropListView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    _dd1.inputTextField.placeholder = @"请输入服务器地址";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:newFielPath];
    if (![fileManager fileExistsAtPath:newFielPath]) {
        [fileManager createFileAtPath:newFielPath contents:nil attributes:nil];
        NSLog(@"不存在,创建文件");
    } else {
        NSLog(@"存在");
    }
    _dd1.tableArray = arr;
    [self.view addSubview:_dd1];
    _dd1.delegate = self;
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    NSLog(@"%@", newFielPath);
    
    NSArray *arr1 = [NSArray arrayWithContentsOfFile:newFielPath];
    NSLog(@"%@", arr1);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - DropListViewDelegate

- (void)DropListViewDidEndEditing:(UITextField *)textField
{
    if (textField == self.dd1.inputTextField) {
        NSLog(@"inputText:%@", textField.text);
        NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:newFielPath];
        
        if ([textField.text isEqualToString:@""]) {
            return;
        }
        if ([tempArray containsObject:textField.text]) {
            [tempArray removeObject:textField.text];
        }
        
        if (tempArray) {
            [tempArray insertObject:textField.text atIndex:0];
        } else {
            tempArray = [NSMutableArray arrayWithObjects:textField.text, nil];
        }
        
        if (tempArray.count > 5) {
            [tempArray removeObjectAtIndex:5];
        }
        
        NSLog(@"%@", tempArray);
        
        [tempArray writeToFile:newFielPath atomically:YES];
    }
    
}

- (void)DropListViewBeginShow
{
    _dd1.tableArray = [NSArray arrayWithContentsOfFile:newFielPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
