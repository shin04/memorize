//
//  settingCardViewController.m
//  word
//
//  Created by 梶原大進 on 2015/07/14.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "settingCardViewController.h"
#import "AppDelegate.h"

@implementation settingCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ナビゲーションバーを透過
    [navigation setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigation setShadowImage:[[UIImage alloc] init]];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (!app.titleArray) {
        app.titleArray = [[NSMutableArray alloc] init];
    }
    
    titleText.delegate = self;
    Coordinate_X = 60;
    Coordinate_Y = 10;
    
    if (!app.questionDic) {
        app.questionDic = [NSMutableDictionary dictionary];
    }
    
    if (!app.answerDic) {
        app.answerDic = [NSMutableDictionary dictionary];
    }
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    CGRect rect3 = CGRectMake(0, 200, 320, 408);
    scrollView.frame = rect3;
    
    //スクロールビューに表示するbv
    for (int c = 0; [[app.wordArray objectAtIndex:app.count] intValue] >= c; c++) {
        NSLog(@"%d回目です", c);
        CGRect rect1 = CGRectMake(Coordinate_X, Coordinate_Y, 200, 50);
        UITextView *confText_Q = [[UITextView alloc] initWithFrame:rect1];
        confText_Q.editable = NO;
        confText_Q.text = [NSString stringWithFormat:@"問い：%@", app.questionArray[c]];
        NSLog(@"%@", confText_Q.text);
        
        CGRect rect2 = CGRectMake(Coordinate_X, Coordinate_Y + 70, 200, 50);
        UITextView *confText_A = [[UITextView alloc] initWithFrame:rect2];
        confText_A.editable = NO;
        confText_A.text = [NSString stringWithFormat:@"答え：%@", app.answerArray[c]];
        NSLog(@"%@", confText_A.text);
        
        [scrollView addSubview:confText_Q];
        [scrollView addSubview:confText_A];
        
        Coordinate_Y += 140;
    }
    
    [scrollView setContentSize:CGSizeMake(320, Coordinate_Y)];
    [scrollView flashScrollIndicators];
    //scrollView.contentSize = CGSizeMake(320, Coordinate_Y);
    NSLog(@"スクロールビューの幅は%dです",Coordinate_Y);
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//エンターが押された時の処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app.titleArray insertObject:titleText.text atIndex:app.count];
    NSLog(@"titleText.text = %@ , count = %d", titleText.text, app.count);
    NSLog(@"titleArray[%d] = %@", app.count, [app.titleArray objectAtIndex:app.count]);
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)completion:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //[app.wordArray insertObject:[NSNumber numberWithInt:app.wordCount] atIndex:app.count];
    app.count ++;
    NSLog(@"count =  %d", app.count);
    
    //dictionaryに問いと答えを保存
    //この時のdictionaryのkeyに titleText.text と 問いと答えが入っているarrayの番号 を結合したものを使う
    for (int c = 0; [[app.wordArray objectAtIndex:app.count - 1] intValue] >= c; c++) {
        //dictionaryのkeyにする文字列を作成
        NSString *Int;
        NSString *dicKey;
        Int = [NSString stringWithFormat:@"%d", c];
        dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.count - 1]];
        NSLog(@"dicKey = %@",dicKey);
        
        //questionDicに問いを保存
        //app.questionDic = [NSMutableDictionary dictionaryWithObject:[app.questionArray objectAtIndex:c] forKey:dicKey];
        app.questionDic[dicKey] = [app.questionArray objectAtIndex:c];
        NSLog(@"questionDicに%@が保存されました\nキーは%@", [app.questionDic objectForKey:dicKey], dicKey);
        
        //answerDicに答えを保存
        //app.answerDic = [NSMutableDictionary dictionaryWithObject:[app.answerArray objectAtIndex:c] forKey:dicKey];
        app.answerDic[dicKey] = [app.answerArray objectAtIndex:c];
        NSLog(@"answerDicに%@が保存されました\nキーは%@", [app.answerDic objectForKey:dicKey], dicKey);
        
        NSLog(@"%@\n%@", [app.questionDic objectForKey:@"0あ"], [app.questionDic objectForKey:@"1あ"]);
    }
    
    //userdefoultsに保存
    app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
    [app.nsuserdefaults setObject:app.questionDic forKey:@"question"];
    [app.nsuserdefaults setObject:app.answerDic forKey:@"answer"];
    NSArray *array = [app.titleArray mutableCopy];
    [app.nsuserdefaults setObject:array forKey:@"title"];
    NSArray *array2 = [app.wordArray mutableCopy];
    [app.nsuserdefaults setObject:array2 forKey:@"word"];
    //[app.nsuserdefaults setObject:app.titleArray forKey:@"titleArray"];
    [app.nsuserdefaults setInteger:app.count forKey:@"count"];
    [app.nsuserdefaults synchronize];
}

@end