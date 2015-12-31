//
//  WritingViewController.h
//  word
//
//  Created by 梶原大進 on 2015/05/23.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

@interface WritingViewController : UIViewController
{
    IBOutlet UIImageView *canvas;
    IBOutlet UINavigationBar *navigation;
    
    AVAudioPlayer *pen;
    SystemSoundID sound;
}

- (IBAction)back:(id)sender;
- (IBAction)newButton:(id)sender;

@end
