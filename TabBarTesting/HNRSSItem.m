//
//  HNRSSItem.m
//  HN RSS Reader
//
//  Created by Camron Schwoegler on 10/17/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "HNRSSItem.h"

@implementation HNRSSItem

@synthesize parentParserDelegate, title, link, commentsLink;

- (BOOL)read
{
    return read;
}

- (void)setRead:(BOOL)r
{
    read = r;
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"link"]) {
        currentString = [[NSMutableString alloc] init];
        [self setLink:currentString];
    } else if ([elementName isEqual:@"comments"]) {
        currentString = [[NSMutableString alloc] init];
        [self setCommentsLink:currentString];
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}


- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    currentString = nil;
    
    if ([elementName isEqual:@"item"]) {
        [parser setDelegate:parentParserDelegate];
    }
}
@end
