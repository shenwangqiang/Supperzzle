//
//  ViewController.m
//  Supperzzle
//
//  Created by 沈王强 on 2017/8/12.
//  Copyright © 2017年 沈王强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImage* _lastImage;
}
@end

@implementation ViewController

-(void) startGame{
    //图像名字数组
    NSMutableArray* arrStr = [[NSMutableArray alloc] init];
    for(int k = 0; k < 18 ;k++){
        int random = arc4random() % 7 + 1;
        NSString* strName = [NSString stringWithFormat:@"%d",random];
        [arrStr addObject:strName];
        [arrStr addObject:strName];
    }
    //循环创建自定义按钮
    for (int i = 0 ; i < 6 ; i ++){
        for(int j = 0 ; j< 6 ; j ++){
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            // 添加动画
            btn.frame = CGRectMake(j>=3?10+50*5:10 ,i>=3?140+50*5:140 ,50 ,50);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            btn.frame = CGRectMake(10+50*j ,140+50*i ,50 ,50);
            [UIView commitAnimations];
            
            int indexRandom = arc4random() % arrStr.count ;
            
            NSString* strImage = arrStr[indexRandom];
            
            NSInteger tag = [strImage integerValue];
            
            [arrStr removeObjectAtIndex:indexRandom];
            
            UIImage* image = [UIImage imageNamed:strImage];
            
            [btn setImage:image forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            //将按钮的标志位赋值
            btn.tag = tag;
        }
    }
}


- (void) pressBtn: (UIButton*) btn
{
    //创建一个静态变量，保存第一次按下按钮的风格
    static UIButton* btnFirst = nil;
    if (btnFirst == nil) {
        btnFirst = btn;
        //锁定第一个按钮
        btnFirst.enabled = NO;
    }else if(btnFirst == btn){
        // 同一按钮取消选中
        btnFirst.enabled = YES;
        btnFirst = nil;
    }else if(btnFirst.tag == btn.tag) {
        //如果两个按钮相同
        btnFirst.hidden = YES;
        btn.tag = YES;
        btnFirst = nil;
        btn.hidden = YES;
    }else{
        //如果两个按钮不相同
        btnFirst.enabled = YES;
        btnFirst = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startGame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
