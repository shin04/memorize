//
//  memorizationViewController.h
//  word
//
//  Created by 梶原大進 on 2015/07/19.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"

@interface memorizationViewController : UIViewController
<UIScrollViewDelegate>
{
    int TagNumber;
    int wordNumber; //カードの数を保存
    int randomNumber; //ランダム表示の時に乱数を記憶
    int Coordinate_X; //スクロールビューの横幅
    int point; //スクロールする時に移動する座標
    
    NSString *Int;
    NSString *dicKey;
    
    IBOutlet UIImageView *image;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UISwitch *random;
    IBOutlet UISwitch *exchange;
    IBOutlet UILabel *answerLabel;
    
    IBOutlet UIButton *button;
    IBOutlet UIButton *right;
    IBOutlet UIButton *left;
}

- (IBAction)makeRandom:(id)sender;
- (IBAction)exchanging:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)left:(id)sender;

@end
