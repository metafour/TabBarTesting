//
//  TBTTableViewController.h
//  TabBarTesting
//
//  Created by Camron Schwoegler on 10/23/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNRSSChannel;

@interface TBTTableViewController : UITableViewController <NSXMLParserDelegate>
{
    NSURLConnection *dataConnection;
    NSMutableData *xmlData;
    HNRSSChannel *channel;
}

@end
