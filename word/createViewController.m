//
//  createViewController.m
//  word
//
//  Created by 梶原大進 on 2015/07/13.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "createViewController.h"
#import "AppDelegate.h"
#import "settingCardViewController.h"

@implementation createViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ナビゲーションバーを透過
    [navigation setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigation setShadowImage:[[UIImage alloc] init]];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (!app.questionArray) {
        app.questionArray = [[NSMutableArray array] init];
    }
    
    if (!app.answerArray) {
        app.answerArray = [[NSMutableArray array] init];
    }
    
    if (!app.wordArray) {
        app.wordArray = [[NSMutableArray array] init];
    }
    
    questionText.delegate = self;
    answerText.delegate = self;
}

//キーボードを閉じる処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app.questionArray removeAllObjects];
    [app.answerArray removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)front:(id)sender {
    wordCount += 1;
    rearBtn.alpha = 1;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    questionText.text = [app.questionArray objectAtIndex:wordCount];
    answerText.text = [app.answerArray objectAtIndex:wordCount];
    if (app.questionArray.count - 1 == wordCount) {
        frontBtn.alpha = 0;
    }
}

- (IBAction)rear:(id)sender {
    wordCount -= 1;
    NSLog(@"questionTextには%@と書かれています", questionText.text);
    if (![questionText.text isEqual:@""] && ![answerText.text isEqual:@""]) {
        frontBtn.alpha = 1;
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    questionText.text = [app.questionArray objectAtIndex:wordCount];
    answerText.text = [app.answerArray objectAtIndex:wordCount];
    if (wordCount == 0) {
        rearBtn.alpha = 0;
    }
}

- (IBAction)ActQuestion:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (app.questionArray.count == wordCount) {
        [app.questionArray insertObject:questionText.text atIndex:wordCount];
        NSLog(@"要素を追加したよー");
    } else {
        [app.questionArray replaceObjectAtIndex:wordCount withObject:questionText.text];
        NSLog(@"要素を更新したよー");
    }
    NSLog(@"%d番目に%@が保存されました", wordCount, [app.questionArray objectAtIndex:wordCount]);
}

- (IBAction)ActAnswer:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (app.answerArray.count == wordCount) {
        [app.answerArray insertObject:answerText.text atIndex:wordCount];
        NSLog(@"要素を追加したよー");
    } else {
        [app.answerArray replaceObjectAtIndex:wordCount withObject:answerText.text];
        NSLog(@"要素を更新したよー");
    }
    NSLog(@"%d番目に%@が保存されました", wordCount, [app.answerArray objectAtIndex:wordCount]);
}

- (IBAction)newCard:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"%lu %lu", (unsigned long)app.questionArray.count, (unsigned long)app.answerArray.count);
    if (app.questionArray.count != app.answerArray.count) {
        [self keikoku];
    } else if (app.questionArray.count == 0 && app.answerArray.count) {
        [self keikoku];
    } else {
        wordCount++;
        questionText.text = nil;
        answerText.text = nil;
        
        rearBtn.alpha = 1;
    }
}

- (IBAction)next:(id)sender {
    NSLog(@"呼ばれたよ");
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"count = %d", app.count);
    [app.wordArray insertObject:[NSNumber numberWithInt:wordCount] atIndex:app.count];
    
    if (app.questionArray.count != app.answerArray.count) {
        [self keikoku];
    } else if (app.questionArray.count == 0 && app.answerArray.count == 0) {
        [self keikoku];
    } else {
        settingCardViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"segue"];
        nextViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nextViewController animated:YES completion:nil];
    }
}

- (void)keikoku{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:nil
                          message:@"問いと答えを設定してください"
                          delegate:self
                          cancelButtonTitle:@"はい"
                          otherButtonTitles:nil];
    [alert show];
}

@end
