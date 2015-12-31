//
//  selectViewController.m
//  word
//
//  Created by 梶原大進 on 2015/07/13.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "selectViewController.h"
#import "AppDelegate.h"
#import "WatchingViewController.h"
#import "editViewController.h"

@implementation selectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myTableView.dataSource = self;
    myTableView.delegate = self;
    
    //ナビゲーションバーを透過
    [navigation setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigation setShadowImage:[[UIImage alloc] init]];
    
    //データの読み込み
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (!app.questionDic && !app.answerDic) {
        app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dic1 = [app.nsuserdefaults dictionaryForKey:@"question"];
        app.questionDic = [dic1 mutableCopy];
        NSDictionary *dic2 = [app.nsuserdefaults dictionaryForKey:@"answer"];
        app.answerDic = [dic2 mutableCopy];
        app.titleArray = [app.nsuserdefaults mutableArrayValueForKey:@"title"];
        app.wordArray = [app.nsuserdefaults mutableArrayValueForKey:@"word"];
        app.count = (int)[app.nsuserdefaults integerForKey:@"count"];
        
        NSLog(@"count = %d", app.count);
    }
    
    NSLog(@"%@, %@, %@", [app.questionDic objectForKey:@"0あ"], [app.questionDic objectForKey:@"1あ"], [app.questionDic objectForKey:@"2あ"]);
}

- (void)viewWillAppear:(BOOL)animated {
    [myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//テーブルの設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"行数は%dです", app.count);
    return app.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    cell.textLabel.text = app.titleArray[indexPath.row];
    
    NSLog(@"cell.textlabel.text = %@", app.titleArray[indexPath.row]);
    NSLog(@"セル数は %ld + 1 です", (long)indexPath.row);
    
    return cell;
}

//セルが選択された時に行う処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    app.cellPath = (int)indexPath.row;
    
    //alertControllerを作成
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    // addActionした順に左から右にボタンが配置されます
    [alert addAction:[UIAlertAction actionWithTitle:@"移動"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                //移動が押された時の処理
                                                WatchingViewController *WatchingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"registered"];
                                                WatchingViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                                                [self presentViewController:WatchingViewController animated:YES completion:nil];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"編集"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                //編集画面に遷移
                                                editViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"edit"];
                                                edit.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                                                [self presentViewController:edit animated:YES completion:nil];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"削除"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                //削除が押された時の処理
                                                for (int c = 0; [[app.wordArray objectAtIndex:app.cellPath] intValue] >= c; c++) {
                                                    //dictionaryのkeyにする文字列を作成
                                                    NSString *Int;
                                                    NSString *dicKey;
                                                    Int = [NSString stringWithFormat:@"%d", c];
                                                    dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.cellPath]];
                                                    NSLog(@"dicKey = %@",dicKey);
                                                    
                                                    NSLog(@"%@, %@を削除します", [app.questionDic objectForKey:dicKey],[app.answerDic objectForKey:dicKey]);
                                                    
                                                    //問いと答えを削除
                                                    [app.questionDic removeObjectForKey:dicKey];
                                                    [app.answerDic removeObjectForKey:dicKey];
                                                    
                                                    NSLog(@"削除しました%@, %@", [app.questionDic objectForKey:dicKey], [app.answerDic objectForKey:dicKey]);
                                                }
                                                //タイトルを削除
                                                [app.titleArray removeObjectAtIndex:app.cellPath];
                                                
                                                //tableViewの行を削除
                                                app.count -= 1;
                                                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                
                                                //データの更新を保存
                                                app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
                                                [app.nsuserdefaults setObject:app.questionDic forKey:@"question"];
                                                [app.nsuserdefaults setObject:app.answerDic forKey:@"answer"];
                                                NSArray *array = [app.titleArray mutableCopy];
                                                [app.nsuserdefaults setObject:array forKey:@"title"];
                                                [app.nsuserdefaults setInteger:app.count forKey:@"count"];
                                                [app.nsuserdefaults synchronize];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"キャンセル"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
}

//セルの左すワイプに必要
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @[
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                title:@"削除"
                                              handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                  //削除が押された時の処理
                                                  AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                                  
                                                  for (int c = 0; [[app.wordArray objectAtIndex:app.cellPath] intValue] >= c; c++) {
                                                      //dictionaryのkeyにする文字列を作成
                                                      NSString *Int;
                                                      NSString *dicKey;
                                                      Int = [NSString stringWithFormat:@"%d", c];
                                                      dicKey = [Int stringByAppendingString:[app.titleArray objectAtIndex:app.cellPath]];
                                                      NSLog(@"dicKey = %@",dicKey);
                                                      
                                                      NSLog(@"%@, %@を削除します", [app.questionDic objectForKey:dicKey],[app.answerDic objectForKey:dicKey]);
                                                      
                                                      //問いと答えを削除
                                                      [app.questionDic removeObjectForKey:dicKey];
                                                      [app.answerDic removeObjectForKey:dicKey];
                                                      
                                                      NSLog(@"削除しました%@, %@", [app.questionDic objectForKey:dicKey], [app.answerDic objectForKey:dicKey]);
                                                  }
                                                  //タイトルを削除
                                                  [app.titleArray removeObjectAtIndex:app.cellPath];
                                                  
                                                  //tableViewの行を削除
                                                  app.count -= 1;
                                                  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                  
                                                  //データの更新を保存
                                                  app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
                                                  [app.nsuserdefaults setObject:app.questionDic forKey:@"question"];
                                                  [app.nsuserdefaults setObject:app.answerDic forKey:@"answer"];
                                                  NSArray *array = [app.titleArray mutableCopy];
                                                  [app.nsuserdefaults setObject:array forKey:@"title"];
                                                  [app.nsuserdefaults setInteger:app.count forKey:@"count"];
                                                  [app.nsuserdefaults synchronize];
                                              }],
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                title:@"戻す"
                                              handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                  // own action
                                                  [tableView setEditing:NO animated:YES];
                                              }],
             ];
}

@end
