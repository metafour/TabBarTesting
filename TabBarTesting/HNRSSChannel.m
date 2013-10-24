//
//  HNRSSChannel.m
//  HN RSS Reader
//
//  Created by Camron Schwoegler on 10/17/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "HNRSSChannel.h"
#import "HNRSSItem.h"

@implementation HNRSSChannel

@synthesize parentParserDelegate, title, infoString, items;

- (id)init
{
    self = [super init];
    
    if (self) {
        items = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t%@ found a %@", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    } else if ([elementName isEqual:@"description"])
    {
        currentString = [[NSMutableString alloc] init];
        [self setInfoString:currentString];
    } else if ([elementName isEqual:@"item"]) {
        HNRSSItem *item = [[HNRSSItem alloc] init];
        
        [item setParentParserDelegate:self];
        
        [parser setDelegate:item];
        
        [items addObject:item];
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
    
    if ([elementName isEqual:@"channel"]) {
        [parser setDelegate:parentParserDelegate];
    }
}

@end

