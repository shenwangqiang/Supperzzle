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
    UIButton* _lastBtn;
    int _count;
}
@end

@implementation ViewController

-(void) startGame{
    //图像名字数组
    _count = 0;
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
    
    if (_lastBtn == nil) {
        _lastBtn = btn;
        //锁定第一个按钮
        _lastBtn.enabled = NO;
    }else if(_lastBtn.tag == btn.tag) {
        //如果两个按钮相同
        
        
        
        // 消除动画
        [UIView animateWithDuration:2 animations:^{
            int x = (_lastBtn.frame.origin.x+btn.frame.origin.x)/2;
            int y  = (_lastBtn.frame.origin.y+btn.frame.origin.y)/2;
            btn.frame = CGRectMake(x ,y ,50 ,50);
            _lastBtn.frame = CGRectMake(x, y, 50, 50);
            btn.alpha = 0;
            _lastBtn.alpha = 0;
        } completion:^(BOOL finished){
            if(finished){
                _lastBtn.hidden = YES;
                btn.tag = YES;
                _lastBtn = nil;
                btn.hidden = YES;
                _count++;
            }
            if(_count==18){
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"恭喜过关，是否再来一次？" delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"好的", nil];
                [alertview setDelegate:self];
                [alertview show];
            }
        }];
        
    }else{
        //如果两个按钮不相同
        _lastBtn.enabled = YES;
        _lastBtn = nil;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        exit(0);
    } else {
        [self startGame];
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
