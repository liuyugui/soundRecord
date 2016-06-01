//
//  ViewController.m
//  soundRecord
//
//  Created by 法大大 on 16/6/1.
//  Copyright © 2016年 liuyugui. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>//注意导入引用库

@interface ViewController ()<AVAudioPlayerDelegate,AVAudioRecorderDelegate>{
    
    BOOL recording;
    NSURL *tmpFile;
    AVAudioRecorder *recorder;
    AVAudioPlayer *audioPlayer;
}

@end

@implementation ViewController

- (IBAction)luyinBtnClick:(UIButton *)sender {
    
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    
    if (!recording) {
        
        recording = YES;
        [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        [audioSession setActive:YES error:nil];
        
        [sender setTitle:@"停止" forState:UIControlStateNormal];
        
        NSDictionary *setting = [[NSDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithFloat: 44100.0],AVSampleRateKey, [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey, [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey, [NSNumber numberWithInt: 2], AVNumberOfChannelsKey, [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey, [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,nil]; //然后直接把文件保存成.wav就好了
        
        tmpFile = [NSURL fileURLWithPath:
                   [NSTemporaryDirectory() stringByAppendingPathComponent:
                    [NSString stringWithFormat: @"%@.%@",
                     @"wangshuo",
                     @"caf"]]];
        recorder = [[AVAudioRecorder alloc] initWithURL:tmpFile settings:setting error:nil];
        
        recorder.delegate = self;
        
        [recorder prepareToRecord];
        [recorder record];
    } else {
        recording = NO;
        [audioSession setActive:NO error:nil];
        [recorder stop];
        [sender setTitle:@"录音" forState:UIControlStateNormal];
    }
    
}


- (IBAction)bofangBtnClick:(id)sender {
    
    NSError *error;
    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:tmpFile
                                                      error:&error];
    
    audioPlayer.volume=1;
    audioPlayer.delegate = self;
    if (error) {
        NSLog(@"error:%@",[error description]);
        return;
    }
    //准备播放
    [audioPlayer prepareToPlay];
    //播放
    [audioPlayer play];
}

//当播放结束后调用这个方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    NSLog(@"播放完了");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
