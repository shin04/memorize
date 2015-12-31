//
//  DictionaryViewController.m
//  word
//
//  Created by 梶原大進 on 2015/08/20.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "DictionaryViewController.h"
#import "AppDelegate.h"
#import "contentViewController.h"

@implementation DictionaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mytableView.dataSource = self;
    mytableView.delegate = self;
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (!app.dictionaryTitle) {
        app.dictionaryTitle = [[NSMutableArray array] init];
    }
    
    if (!app.dictionaryText) {
        app.dictionaryText = [[NSMutableArray array] init];
    }
    
    //ナビゲーションバーを透過
    [navigation setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigation setShadowImage:[[UIImage alloc] init]];
    
    //データ読み込み
    NSLog(@"読み込む中");
    app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
    app.dictionaryText = [app.nsuserdefaults mutableArrayValueForKey:@"dic_text"];
    app.dictionaryTitle = [app.nsuserdefaults mutableArrayValueForKey:@"dic_title"];
    app.dicCount = (int)[app.nsuserdefaults integerForKey:@"dic_count"];
    [app.nsuserdefaults synchronize];
}

- (void)viewWillAppear:(BOOL)animated {
    [mytableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)newDic:(id)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app.dictionaryTitle insertObject:@"題名" atIndex:app.dicCount];
    [app.dictionaryText insertObject:@"内容" atIndex:app.dicCount];
    app.dicCount += 1;
    
    //データ保存
    app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [app.dictionaryTitle mutableCopy];
    [app.nsuserdefaults setObject:array forKey:@"dic_title"];
    NSArray *array2 = [app.dictionaryText mutableCopy];
    [app.nsuserdefaults setObject:array2 forKey:@"dic_text"];
    [app.nsuserdefaults setInteger:app.dicCount forKey:@"dic_count"];
    [app.nsuserdefaults synchronize];
    
    [mytableView reloadData];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//テーブルの設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"%d行です", app.dicCount);
    return app.dicCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"Cell";
    
    UITableViewCell *cell = [mytableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    cell.textLabel.text = app.dictionaryTitle[indexPath.row];
    
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
    [alert addAction:[UIAlertAction actionWithTitle:@"見る"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                [self MkAlert:[app.dictionaryText objectAtIndex:app.cellPath]
                                                             :[app.dictionaryTitle objectAtIndex:app.cellPath]];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"編集"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                contentViewController *content = [self.storyboard instantiateViewControllerWithIdentifier:@"content"];
                                                content.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                                                [self presentViewController:content animated:YES completion:nil];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"削除"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                [self deleteData:indexPath :tableView];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"キャンセル"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @[
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                title:@"削除"
                                              handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                  [self deleteData:indexPath :tableView];
                                              }],
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                title:@"戻す"
                                              handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                  // own action
                                                  [tableView setEditing:NO animated:YES];
                                              }],
             ];
}

-(void)deleteData:(NSIndexPath *)indexPath :(UITableView *)tableView {
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //削除が押された時の処理
    [app.dictionaryTitle removeObjectAtIndex:indexPath.row];
    [app.dictionaryText removeObjectAtIndex:indexPath.row];
    
    //tableViewの行を削除
    app.dicCount -= 1;
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    //データの更新を保存
    app.nsuserdefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [app.dictionaryTitle mutableCopy];
    [app.nsuserdefaults setObject:array forKey:@"dic_title"];
    NSArray *array2 = [app.dictionaryText mutableCopy];
    [app.nsuserdefaults setObject:array2 forKey:@"dic_text"];
    [app.nsuserdefaults setInteger:app.dicCount forKey:@"dic_count"];
    [app.nsuserdefaults synchronize];
}

-(void)MkAlert:(NSString *)title :(NSString *)content {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
