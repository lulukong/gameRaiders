//
//  ViewController.m
//  GameRaiders
//
//  Created by lulu on 14-3-7.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView setDelegate:self];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"build/index" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    webView.scalesPageToFit = YES;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    [NSThread detachNewThreadSelector:@selector(requestAd) toTarget:self withObject:nil];

}

- (void)requestAd
{
    NSString *url = [NSString stringWithFormat:@"http://a.yxpopo.com/xp_ad_ios.php"];
    ASIHTTPRequest *adRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    adRequest.delegate = self;
    [adRequest startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");    //图片大小 320*568  按钮 
}


- (void)requestFinished:(ASIHTTPRequest *)httprequest
{
    NSLog(@"%@",[httprequest responseString]);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:httprequest.responseData options:NSJSONReadingMutableContainers error:nil];
    NSString *status = [dic objectForKey:@"status"];
    if ([status isEqualToString:@"1"]) {
        //add ad
        adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        adView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:adView];
        adView.backgroundColor = [UIColor blackColor];
        adView.alpha = 0.7;
        adView.opaque = NO;
        
//        [UIView beginAnimations:@"pageCurl" context:nil];
//        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//        [UIView setAnimationDuration:3.0];
//        [UIView setAnimationDelegate:self];
//        // Make the animatable changes.
//        adView.alpha = 0.7;
//        // Commit the changes and perform the animation.
//        [UIView commitAnimations];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 380, 230, 60)];
        adContent = [dic objectForKey:@"ad_text"];
        contentLabel.textColor  = [UIColor yellowColor];
        contentLabel.text = adContent;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:18];
        contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        contentLabel.numberOfLines = 0;
        [adView addSubview:contentLabel];
        NSLog(@"======%@",contentLabel.text);
        
        adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 30, 230, 350)];
        adImage = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"ad_url"]]]];
        adImageView.image = adImage;
        [adView addSubview:adImageView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GotoAppstore:)];
        adImageView.userInteractionEnabled = YES;
        [adImageView addGestureRecognizer:singleTap];
        
        NSString *is_close = [dic objectForKey:@"is_close"];
        if ([is_close isEqualToString:@"0"])
        {
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            closeBtn.frame = CGRectMake(220, 30, 50, 50);
            closeBtn.backgroundColor = [UIColor clearColor];
            [closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(closeAdView) forControlEvents:UIControlEventTouchUpInside];
            [adView addSubview:closeBtn];
        }
    }
}


- (void) closeAdView
{
    [adView removeFromSuperview];
}

- (void) GotoAppstore:(UITapGestureRecognizer*)recognizer
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/bao-wei-luo-bo-gong-e-da-quan/id688052491?mt=8"]];
}



@end


































