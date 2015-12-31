//
//  editViewController.m
//  word
//
//  Created by 梶原大進 on 2015/10/10.
//  Copyright © 2015年 梶原大進. All rights reserved.
//

#import "editViewController.h"
#import "AppDelegate.h"

@implementation editViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Coordinate_Y = 10;
    
    //ナビゲーションバーを透過
    [navigation setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigation setShadowImage:[[UIImage alloc] init]];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //titleの設定
    self.titleText = [[UITextField alloc] initWithFrame:CGRectMake(87, 100, 200, 30)];
    NSLog(@"cellpath = %d", app.cellPath);
    self.titleText.text = app.titleArray[app.cellPath];
    self.titleText.delegate = self;
    NSLog(@"titleText.text = %@", [app.titleArray objectAtIndex:app.cellPath]);
    
    [self.view addSubview:self.titleText];
    
    //スクロールビューの作成
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 150, 320, 320)];
    scroll.delegate = self;
    
    //textfieldに問いと答えを表示していく
    for (int c = 0; c <= [[app.wordArray objectAtIndex:app.cellPath] intValue]; c++) {
        //dictionaryのkeyを作成
        NSString *Int;
        NSString *dicKey;
        Int = [NSString stringWithFormat:@"%d", c];
        dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.count - 1]];
        NSLog(@"dicKey = %@",dicKey);
        
        //問いをスクロール上に表示
        self.Qtext = [[UITextField alloc] initWithFrame:CGRectMake(30, Coordinate_Y, 200, 30)];
        self.Qtext.tag = c + 1;
        self.Qtext.text = [app.questionDic objectForKey:dicKey];
        [scroll addSubview:self.Qtext];
        
        self.Qtext.delegate = self;
        
        Coordinate_Y += 40;
        
        //答えをスクロール上に表示
        self.Atext = [[UITextField alloc] initWithFrame:CGRectMake(30, Coordinate_Y, 200, 30)];
        self.Atext.tag = 1001 + c;
        self.Atext.text = [app.answerDic objectForKey:dicKey];
        [scroll addSubview:self.Atext];
        
        self.Atext.delegate = self;
        
        Coordinate_Y += 60;
    }
    
    [scroll setContentSize:CGSizeMake(320, Coordinate_Y)];
    [scroll flashScrollIndicators];
    NSLog(@"scrollViewの長さは%dです", Coordinate_Y);
    [self.view addSubview:scroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//エンターが押された時の処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)save:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    for (int c = 0; c <= [[app.wordArray objectAtIndex:app.cellPath] intValue]; c++) {
        //dictionaryのkeyを作成
        NSString *Int;
        NSString *dicKey;
        Int = [NSString stringWithFormat:@"%d", c];
        dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.count - 1]];
        NSLog(@"dicKey = %@",dicKey);
        
        UITextField *Qcontent = (UITextField*) [self.view viewWithTag:c + 1];
        UITextField *Acontent = (UITextField*) [self.view viewWithTag:c + 1001];
        
        [app.questionDic setObject:Qcontent.text forKey:dicKey];
        [app.answerDic setObject:Acontent.text forKey:dicKey];
        
        app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
        [app.titleArray insertObject:self.titleText.text atIndex:app.cellPath];
        [app.nsuserdefaults setObject:app.questionDic forKey:@"question"];
        [app.nsuserdefaults setObject:app.answerDic forKey:@"answer"];
        [app.nsuserdefaults synchronize];
    }
    
    NSLog(@"保存しました");
    //alertControllerを作成
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"確認"
                                                                   message:@"保存しました"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    // addActionした順に左から右にボタンが配置されます
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                  //OKが押された時の処理
                                              }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
