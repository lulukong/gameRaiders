//
//  ViewController.h
//  GameRaiders
//
//  Created by lulu on 14-3-7.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIView *adView;
    
    UIImage *adImage;
    UIImageView *adImageView;
    NSString *adContent;
    UILabel *contentLabel;
}

@end
