//
//  TBTSecondViewController.m
//  TabBarTesting
//
//  Created by Camron Schwoegler on 10/23/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "TBTSecondViewController.h"
#import "HNRSSItem.h"

@implementation TBTSecondViewController

@synthesize webView, item;

- (void)viewWillAppear:(BOOL)animated
{
    NSURL *url = [NSURL URLWithString:[item commentsLink]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
