//
//  memorizationViewController.m
//  word
//
//  Created by 梶原大進 on 2015/07/19.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "memorizationViewController.h"
#import "AppDelegate.h"

@implementation memorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Coordinate_X = 0;
    //point = 375;
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //wordArrayからカードの数を取り出す
    wordNumber = [[app.wordArray objectAtIndex:app.cellPath] intValue];
    NSLog(@"wordNumber = %d", [[app.wordArray objectAtIndex:app.cellPath] intValue]);
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    CGRect rect = CGRectMake(0, 50, 375, 150);
    scrollView.frame = rect;
    
    //スクロールできないようにする
    [scrollView setScrollEnabled:NO];
    
    [self display];
    
    [scrollView setContentSize:CGSizeMake(Coordinate_X, 50)];
    [scrollView flashScrollIndicators];
    [self.view addSubview:scrollView];
    //最背面からimage,scrollViewという並びにする
    [self.view sendSubviewToBack:scrollView];
    [self.view sendSubviewToBack:image];
    
    answerLabel = [[UILabel alloc] init];
    answerLabel.frame = CGRectMake(0, 200, 375, 50);
    [self.view addSubview:answerLabel];
    
    if (wordNumber == 0) {
        right.alpha = 0;
        left.alpha = 0;
    } else if (wordNumber > 0) {
        right.alpha = 1;
        left.alpha = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)makeRandom:(id)sender {
    answerLabel.text = nil;
    
    if (random.on == YES) {
        NSLog(@"スイッチはONです");
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //一旦scrollView上のbuttonを全て削除
        for (int c = 0; wordNumber >= c; c++) {
            NSLog(@"%d番目のbuttonを削除", c);
            [[scrollView viewWithTag:c + 1] removeFromSuperview];
        }
        
        TagNumber = 0;
        Coordinate_X = 0;
        
        //重複のない乱数を作成
        int a[wordNumber + 1];
        
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
        
        //問いと答えをランダムで再表示
        for (int c = 0; wordNumber >= c; c++) {
            NSLog(@"%d回目です", c);
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(Coordinate_X + 50, 50, 275, 50);
            
            //dictionaryのkeyになる文字列を作成
            Int = [NSString stringWithFormat:@"%d", a[c]];
            dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.cellPath]];
            NSLog(@"dicKey = %@", dicKey);
            
            [button setTitle:[app.questionDic objectForKey:dicKey] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            NSLog(@"button.title = %@", [app.questionDic objectForKey:dicKey]);
            
            //TagNumber ++;
            //button.tag = TagNumber;
            
            button.tag = a[c] + 1;
            
            [button addTarget:self
                       action:@selector(ac_button:)
             forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:button];
            
            Coordinate_X += 375;
        }
        
    } else {
        NSLog(@"元に戻します");
        
        //一旦scrollView上のbuttonを全て削除
        for (int c = 0; wordNumber >= c; c++) {
            NSLog(@"%d番目のbuttonを削除", c);
            [[scrollView viewWithTag:c + 1] removeFromSuperview];
        }
        
        TagNumber = 0;
        Coordinate_X = 0;
        
        [self display];
    }
}

- (IBAction)exchanging:(id)sender {
    answerLabel.text = nil;
    
    if (exchange.on == YES) {
        NSLog(@"入れ替わります");
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //一旦scrollView上のbuttonを全て削除
        for (int c = 0; wordNumber >= c; c++) {
            NSLog(@"%d番目のbuttonを削除", c);
            [[scrollView viewWithTag:c + 1] removeFromSuperview];
        }
         
        TagNumber = 0;
        Coordinate_X = 0;
        
        //問いと答えを入れ替えて表示
        for (int c = 0; wordNumber >= c; c++) {
            NSLog(@"%d回目です", c);
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(Coordinate_X + 50, 50, 275, 50);
            
            //dictionaryのkeyになる文字列を作成
            Int = [NSString stringWithFormat:@"%d", c];
            dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.cellPath]];
            NSLog(@"dicKey = %@", dicKey);
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:[app.answerDic objectForKey:dicKey] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            NSLog(@"button.title = %@", [app.answerDic objectForKey:dicKey]);
            
            TagNumber ++;
            button.tag = TagNumber;
            
            [button addTarget:self
                       action:@selector(ac_button:)
             forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:button];
            
            Coordinate_X += 375;
        }
    } else {
        NSLog(@"元に戻します");
        //一旦scrollView上のbuttonを全て削除
        for (int c = 0; wordNumber >= c; c++) {
            NSLog(@"%d番目のbuttonを削除", c);
            [[scrollView viewWithTag:c + 1] removeFromSuperview];
        }
        
        TagNumber = 0;
        Coordinate_X = 0;
        
        [self display];
    }
}

- (IBAction)right:(id)sender {
    left.alpha = 1;
    point += 375;
    if (scrollView.contentSize.width > point) {
        CGPoint move;
        move.x = point;
        move.y = 0;
        
        //scrollviewをスクロールさせる
        [scrollView setContentOffset:move animated:YES];
         NSLog(@"%dにスクロールします", point);
        
        answerLabel.text = nil;
    }
    
    if (scrollView.contentSize.width == point + 375) {
        NSLog(@"スクロールしません");
        right.alpha = 0;
    }
}

- (IBAction)left:(id)sender {
    right.alpha = 1;
    point -= 375;
    if (point >= 0) {
        
        CGPoint move;
        move.x = point;
        move.y = 0;
        
        //scrollviewをスクロールさせる
        [scrollView setContentOffset:move animated:YES];
        NSLog(@"%dにスクロールします", point);
        
        answerLabel.text = nil;
    }
    
    if (point == 0) {
        NSLog(@"スクロールしません");
        left.alpha = 0;
    }
}

- (void)ac_button:(UIButton *)btn {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    int n;
    n = (int)btn.tag;
    answerLabel.textAlignment = NSTextAlignmentCenter;
    
    Int = [NSString stringWithFormat:@"%d", n - 1];
    dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.cellPath]];
    
    if (exchange.on == YES) {
        [answerLabel setText:[app.questionDic objectForKey:dicKey]];
    } else {
        [answerLabel setText:[app.answerDic objectForKey:dicKey]];
    }
}

- (void)display {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //問いをスクロールビュー上に表示
    for (int c = 0; wordNumber >= c; c++) {
        NSLog(@"%d回目です", c);
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(Coordinate_X + 50, 50, 275, 50);
        
        //dictionaryのkeyになる文字列を作成
        Int = [NSString stringWithFormat:@"%d", c];
        dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.cellPath]];
        NSLog(@"dicKey = %@", dicKey);
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[app.questionDic objectForKey:dicKey] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSLog(@"button.title = %@", [app.questionDic objectForKey:dicKey]);
        
        TagNumber ++;
        button.tag = TagNumber;
        
        [button addTarget:self
                   action:@selector(ac_button:)
         forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        Coordinate_X += 375;
    }
}

- (void)randomMethod {
    
}

- (void)exchangMethod {
    
}

@end
