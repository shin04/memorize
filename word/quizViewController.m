//
//  quizViewController.m
//  word
//
//  Created by 梶原大進 on 2015/07/19.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "quizViewController.h"
#import "AppDelegate.h"
#import "resultViewController.h"

@implementation quizViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    randomArray = [[NSMutableArray array] init];
    
    //wordCountからカードの数を取り出す
    wordNumber = [[app.wordArray objectAtIndex:app.cellPath] intValue];
    NSLog(@"wordNumber = %d", [[app.wordArray objectAtIndex:app.cellPath] intValue]);
    int a[wordNumber + 1];
    
    for (int c = 0; wordNumber >= c; c++) {
        //重複のない乱数を作成
        for(int i = 0; i < wordNumber + 1; i++){
            NSLog(@"%d回目です", i);
            int b = wordNumber + 1;
            a[i] = arc4random() % b;
            
            randomNumber = a[i];
            for(i = 0; i < wordNumber + 1; i++){
                if(a[i] == randomNumber){
                    break;
                }
            }
        }
    }
    
    //dictionaryのkeyになる文字列を作成
    Int = [NSString stringWithFormat:@"%d", a[0]];
    dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.cellPath]];
    NSLog(@"dicKey = %@", dicKey);
    
    questionLabel.text = [app.questionDic objectForKey:dicKey];
    
    for (int c = 1; wordNumber >= c; c++) {
        //randomArray[c] = [NSString stringWithFormat:@"%d", a[c]];
        //[randomArray insertObject:[NSString stringWithFormat:@"%d", a[c]] atIndex:c];
        [randomArray addObject:[NSString stringWithFormat:@"%d", a[c]]];
        //NSLog(@"randomArray[%d] = %@", c, [randomArray objectAtIndex:c]);
    }
    NSLog(@"%@", randomArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)questionButton:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    answerLabal.text = [app.answerDic objectForKey:dicKey];
    
    if ([questionText.text isEqualToString:answerLabal.text]) {
        seStr = @"correct";
        [self playBgm];
        judgeLabel.text = @"正解";
        self.correct += 1;
    } else {
        seStr = @"incorrect";
        [self playBgm];
        judgeLabel.text = @"不正解";
        self.incorrect += 1;
    }
    
    next.alpha = 1;
}

- (IBAction)next:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (nextCount != wordNumber) {
        NSLog(@"%d, %@", nextCount, randomArray[nextCount]);
        Int = randomArray[nextCount];
        dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.cellPath]];
        NSLog(@"dicKey = %@", dicKey);
        
        questionLabel.text = [app.questionDic objectForKey:dicKey];
        NSLog(@"次の問題です %@", [app.questionDic objectForKey:dicKey]);
        answerLabal.text = nil;
        judgeLabel.text = nil;
        questionText.text = nil;
        nextCount += 1;
    } else {
        resultViewController *resultVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"result"];
        
        //secondVC.secondNum = self.firstNum;
        resultVC.correct = self.correct;
        resultVC.incorrect = self.incorrect;
        [self presentViewController:resultVC animated:YES completion:nil];
    }
}

- (void)playBgm {
    // 再生するseのファイルのパスを取得
    NSString *path = [[NSBundle mainBundle] pathForResource:seStr ofType:@"mp3"];
    // パスから、再生するURLを作成する
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    //seを再生するプレイヤーを作成する
    se = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //再生
    [se play];
}

@end
