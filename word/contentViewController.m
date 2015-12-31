//
//  contentViewController.m
//  word
//
//  Created by 梶原大進 on 2015/08/20.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "contentViewController.h"
#import "AppDelegate.h"

@implementation contentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contentText.delegate = self;
    titleText.delegate = self;
    
    //ナビゲーションバーを透過
    [navigation setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigation setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    contentText.text = [app.dictionaryText objectAtIndex:app.cellPath];
    titleText.text = [app.dictionaryTitle objectAtIndex:app.cellPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//エンターが押された時の処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)save:(id)sender {
    [contentText resignFirstResponder];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (![contentText hasText] && [titleText hasText]) {
        //textに何も入力されていない時の処理
        alertStr = @"内容が入力されていません";
        [self makeAlert];
    } if (![titleText hasText] && [contentText hasText]) {
        //titleに何も入力されていない時の処理
        alertStr = @"タイトルが入力されていません";
        [self makeAlert];
    } else if (![contentText hasText] && ![titleText hasText]) {
        //どちらも入力されていない時
        alertStr = @"何も入力されていません";
        [self makeAlert];
    } else {
        //どちらにも入力されている時
        NSLog(@"contentText = %@", contentText.text);
        NSLog(@"titleText = %@", titleText.text);
        [app.dictionaryText insertObject:contentText.text atIndex:app.cellPath];
        [app.dictionaryTitle insertObject:titleText.text atIndex:app.cellPath];
        NSLog(@"cellPath = %d", app.cellPath);
        NSLog(@"内容は%@です", [app.dictionaryText objectAtIndex:app.cellPath]);
        NSLog(@"タイトルは%@です", [app.dictionaryTitle objectAtIndex:app.cellPath]);
        
        //データ保存
        app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
        NSArray *array = [app.dictionaryTitle mutableCopy];
        [app.nsuserdefaults setObject:array forKey:@"dic_title"];
        NSArray *array2 = [app.dictionaryText mutableCopy];
        [app.nsuserdefaults setObject:array2 forKey:@"dic_text"];
        [app.nsuserdefaults synchronize];
        
        //アラート表示
        alertStr = @"保存しました";
        [self makeAlert];
    }
}

- (IBAction)back:(id)sender {
    if (![contentText hasText] && ![titleText hasText]) {
        //どちらも入力されていない時
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        app.dicCount -= 1;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)makeAlert {
    //alertControllerを作成
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"確認"
                                                                   message:alertStr
                                                            preferredStyle:UIAlertControllerStyleAlert];
    // addActionした順に左から右にボタンが配置されます
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                  //OKが押された時の処理
                                              }]];
        
        [self presentViewController:alert animated:YES completion:nil];
}


@end
