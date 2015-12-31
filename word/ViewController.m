//
//  ViewController.m
//  word
//
//  Created by 梶原大進 on 2015/05/23.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"
#import "EAIntroView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //NSUserDefoultsのデータ全削除
    //NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
     
    //初回起動時だけチュートリアルを表示
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasLaunchedOnce"];
    } else { // 初回起動時はこっち
        // UserDefault に一度起動したことを記録
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //チュートリアル設定
        EAIntroPage *page1 = [EAIntroPage page];
        page1.bgImage = [UIImage imageNamed:@"intro1.png"];
        page1.title = @"はじめまして";
        page1.desc = @"ポケット暗記帳へようこそ。このアプリでは暗記帳、雑記帳を使って暗記を行えます。さらに、自分だけの辞書を作ることもできます";
    
        EAIntroPage *page2 = [EAIntroPage page];
        page2.bgImage = [UIImage imageNamed:@"intro2.png"];
        page2.title = @"暗記帳";
        page2.desc = @"はじめに暗記帳を作りましょう。";
    
        EAIntroPage *page3 = [EAIntroPage page];
        page3.bgImage = [UIImage imageNamed:@"intro3.png"];
        page3.title = @"暗記帳";
        page3.desc = @"暗記帳とクイズで覚えることができます";
    
        EAIntroPage *page4 = [EAIntroPage page];
        page4.bgImage = [UIImage imageNamed:@"intro4.png"];
        page4.title = @"雑記帳";
        page4.desc = @"雑記帳では指書きで覚えることができます";
        
        EAIntroPage *page5 = [EAIntroPage page];
        page5.bgImage = [UIImage imageNamed:@"intro5.png"];
        page5.title = @"単語帳";
        page5.desc = @"単語帳では自分だけの単語帳を作る事ができます";
        
        EAIntroPage *page6 = [EAIntroPage page];
        page6.bgImage = [UIImage imageNamed:@"intro1.png"];
        page6.title = @"はじめよう";
        page6.desc = @"さあ、はじめましょう";
        
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4,page5,page6]];
    
        [intro showInView:self.view animateDuration:0.0];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)home:(UIStoryboardSegue *)segue{
}

@end
