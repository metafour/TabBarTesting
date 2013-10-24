//
//  HNRSSItem.h
//  HN RSS Reader
//
//  Created by Camron Schwoegler on 10/17/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNRSSItem : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
    BOOL read;
}

@property (nonatomic, weak) id parentParserDelegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *commentsLink;

- (BOOL)read;
- (void)setRead:(BOOL)r;

@end
