//
//  ViewController.m
//  AudioQueueDemo
//  http://blog.csdn.net/soli/article/details/1297109
//  Created by wangyaoguo on 2018/1/12.
//  Copyright © 2018年 lianluo.com. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "YGAudioFileStream.h"
#import "YGAudioOutputQueue.h"
#import "AQRecorder.h"
#import "PCMFilePlayer.h"

#import "YGAudioUnit.h"


@interface ViewController ()<audioFileStreamDelegate>
{
    YGAudioFileStream *stream;
    AQRecorder *recorder;
    PCMFilePlayer *player;
    YGAudioOutputQueue *outQueue;
    FILE *file;
    UInt64 fileLength;
    
    YGAudioUnit *audioUnit;
}
@end

@implementation ViewController

-(void)audioStreamPacketData:(NSData *)data withDescriptions:(AudioStreamPacketDescription*)packetsDes {
     [outQueue playWithPackets:data withDescriptions:packetsDes];
}

-(void)audioStreamPacketData:(NSData *)data withDescription:(AudioStreamPacketDescription)packetDes {
    [outQueue playWithPacket:data withDescription:packetDes];
}

-(void)audioStreamReadyProducePacket {
    outQueue = [[YGAudioOutputQueue alloc]initWithFormat:stream.format withBufferSize:stream.bufferSize withMagicCookie:stream.magicCookie];
}

//open file
-(void)openAudioFile {
   
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PCMSample" ofType:@"pcm"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    fileLength = [[handle availableData]length];
    file = fopen([path UTF8String], "r");
    if (!file) {
        NSLog(@"open file fail");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    NSError *error;
    //http://www.mamicode.com/info-detail-2019952.html
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:&error];
    if (error != nil) {
        NSLog(@"This is error:%@",error.localizedDescription);
    }
    [[AVAudioSession sharedInstance] setActive:YES error:nil];

     
    recorder = [[AQRecorder alloc]init];
    NSString *docpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docpath stringByAppendingPathComponent:@"record.pcm"];
    player = [[PCMFilePlayer alloc]initWithPcmFilePath:filePath];
    //[self openAudioFile];
    //stream = [[YGAudioFileStream alloc]initWithDelegate:self];
     */
    
    audioUnit = [[YGAudioUnit alloc]init];
}

- (IBAction)recorderplayerStart:(id)sender {
    [audioUnit start];
}

- (IBAction)recorderplayerStop:(id)sender {
    
}

- (IBAction)recorderStart:(id)sender {
    [recorder startRecorder];
}

- (IBAction)recorderStop:(id)sender {
    [recorder stopRecorder];
}

- (IBAction)playerStart:(id)sender {
    [player startPlay];
}

- (IBAction)playerStop:(id)sender {
    [player stopPlay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 NSString *aacPath = [[NSBundle mainBundle]pathForResource:@"AACSample" ofType:@"aac"];
 filePlay = [[AudioFilePlayer alloc]initWithPath:aacPath];
 
 //NSString *pcmPath = [[NSBundle mainBundle]pathForResource:@"record" ofType:@"pcm"];
 NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
 NSString *pcmPath = [docPath stringByAppendingPathComponent:@"recording.pcm"];
 pcmPlay = [[PCMFilePlayer alloc]initWithPcmFilePath:pcmPath];
 */
@end

