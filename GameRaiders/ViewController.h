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
    
    NSString *deviceId;
    NSString *osVersion;
    NSString *model;
    NSString *bundleStatus;
    NSString *openUDID;
    NSString *idfv;
    NSString *idfa;
}


@end
