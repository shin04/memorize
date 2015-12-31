//
//  AppDelegate.h
//  word
//
//  Created by 梶原大進 on 2015/05/23.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property int count;
@property int cellPath;
@property int dicCount;

@property NSMutableArray *questionArray; //問いを保存する
@property NSMutableArray *answerArray; //答えを保存する

@property NSMutableArray *wordArray; //文字数を保存する
@property NSMutableArray *titleArray; //タイトルを保存

@property NSMutableDictionary *questionDic; //問いを保存
@property NSMutableDictionary *answerDic; //答えを保存

@property NSMutableArray *dictionaryTitle; //辞書のタイトルを保存
@property NSMutableArray *dictionaryText; //辞書の内容を保存

@property NSUserDefaults *nsuserdefaults;

@end

