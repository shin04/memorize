//
//  WritingViewController.m
//  word
//
//  Created by 梶原大進 on 2015/05/23.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "WritingViewController.h"

@interface WritingViewController()
{
    UIBezierPath *bezierPath;
    UIImage *lastDrawImage;
    NSMutableArray *undoStack;
    NSMutableArray *redoStack;
}

@end

@implementation WritingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ナビゲーションバーを透過
    [navigation setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigation setShadowImage:[[UIImage alloc] init]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 再生するbgmのファイルのパスを取得
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pen" ofType:@"mp3"];
    // パスから再生するURLを作成する
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    //bgmを再生するプレイヤーを作成する
    pen = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //音量調整
    pen.volume = 100;
    //bgm再生
    [pen play];
    pen.numberOfLoops = -1;
    
                        
    // タッチした座標を取得
    CGPoint currentPoint = [[touches anyObject] locationInView:canvas];
    
    // パスを初期化
    bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineWidth = 4.0;
    [bezierPath moveToPoint:currentPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチ開始時にパスを初期化していない場合は処理を終了
    if (bezierPath == nil){
        return;
    }
    
    // タッチした座標を取得
    CGPoint currentPoint = [[touches anyObject] locationInView:canvas];
    
    // パスにポイントを追加
    [bezierPath addLineToPoint:currentPoint];
    
    // 線を描画します。
    [self drawLine:bezierPath];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //bgm停止
    [pen stop];
    
    // タッチ開始時にパスを初期化していない場合は処理を終了
    if (bezierPath == nil){
        return;
    }
    
    // タッチした座標を取得
    CGPoint currentPoint = [[touches anyObject] locationInView:canvas];
    
    // パスにポイントを追加
    [bezierPath addLineToPoint:currentPoint];
    
    // 線を描画
    [self drawLine:bezierPath];
    
    // 今回描画した画像を保持
    lastDrawImage = canvas.image;
}

- (void)drawLine:(UIBezierPath*)path
{
    // 非表示の描画領域を生成
    UIGraphicsBeginImageContext(canvas.frame.size);
    
    // 描画領域に、前回までに描画した画像を、描画
    [lastDrawImage drawAtPoint:CGPointZero];
    
    // 色をセット
    [[UIColor blueColor] setStroke];
    
    // 線を引く
    [path stroke];
    
    // 描画した画像をcanvasにセットして、画面に表示
    canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 描画を終了
    UIGraphicsEndImageContext();
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)newButton:(id)sender {
    // サウンドの準備
    NSString *path = [[NSBundle mainBundle] pathForResource:@"paper" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &sound);
    
    // サウンドの再生
    AudioServicesPlaySystemSound(sound);
    
    lastDrawImage = nil;
    canvas.image = nil;
}

@end
