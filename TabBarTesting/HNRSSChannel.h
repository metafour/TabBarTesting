//
//  HNRSSChannel.h
//  HN RSS Reader
//
//  Created by Camron Schwoegler on 10/17/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNRSSChannel : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}

@property (nonatomic, weak) id parentParserDelegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, readonly, strong) NSMutableArray *items;

@end
