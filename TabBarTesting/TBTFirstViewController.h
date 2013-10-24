//
//  TBTFirstViewController.h
//  TabBarTesting
//
//  Created by Camron Schwoegler on 10/23/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNRSSItem;

@interface TBTFirstViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) HNRSSItem *item;

@end
