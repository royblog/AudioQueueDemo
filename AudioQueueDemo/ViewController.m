//
//  ViewController.m
//  AudioQueueDemo
//
//  Created by wangyaoguo on 2018/1/12.
//  Copyright © 2018年 lianluo.com. All rights reserved.
//

#import "ViewController.h"
#import "AQRecorder.h"
#import "AQPlayer.h"
@interface ViewController () <recorderDelegate>
{
    AQPlayer *player;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AQRecorder *recorder = [[AQRecorder alloc]initWithDelegate:self];
    [recorder beganRecorder];
    
    player = [[AQPlayer alloc]init];
}

-(void)recordData:(NSData *)data {
    //NSLog(@"receiveData:%lu",(unsigned long)data.length);
    [player playWithData:data];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
