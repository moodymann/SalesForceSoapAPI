//
//  QueryParser.m
//  Soap
//
//  Created by isid on 2015/04/06.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "QueryParser.h"

@implementation QueryParser

@synthesize queryResult;

/*******************************************************************************
 *  init
 *
 */
- (id)init
{
    if ((self = [super init])) {
        self.queryResult = [[QueryResult alloc] init];
        self.queryResult.query = [[Query alloc] init];
        self.queryResult.query.result = [NSMutableArray array];
        self.queryResult.query.sortOrder = [NSMutableArray array];
	}
	return self;
}

#pragma mark -- libxml handler --
/*******************************************************************************
 *  getWebServiceResult
 *
 */
- (WebServiceResult *) getWebServiceResult
{
    return self.queryResult;
}

/*******************************************************************************
 *  startElementLocalName
 *
 */
- (void)startElementLocalName:(const xmlChar *)localname
                       prefix:(const xmlChar *)prefix
                          URI:(const xmlChar *)URI
                nb_namespaces:(int)nb_namespaces
                   namespaces:(const xmlChar **)namespaces
                nb_attributes:(int)nb_attributes
                 nb_defaulted:(int)nb_defaulted
                   attributes:(const xmlChar **)attributes
{
    NSString* cmp = [NSString stringWithUTF8String:(char *)localname];
    
    if ([cmp isEqualToString:@"limit"]) {
        [self.currentElementName setString:@""];
		[self.currentElementName appendString:cmp];
    }else if ([cmp isEqualToString:@"records"]) {
        dict = [[NSMutableDictionary alloc] init];
        sort = [NSMutableArray array];
		[self.currentElementName setString:@""];
		[self.currentElementName appendString:cmp];
    }
	if ([self.currentElementName isEqualToString:@"records"]) {
		if (dict) {
            self.currentElement = [[NSMutableString alloc] initWithString:@""];
		}
    }
}

/*******************************************************************************
 *  endElementLocalName
 *
 */
- (void)endElementLocalName:(const xmlChar *)localname prefix:(const xmlChar *)prefix URI:(const xmlChar *)URI
{
    NSString* cmp = [NSString stringWithUTF8String:(char *)localname];
    
    if ([cmp isEqualToString:@"records"]) {
		[self.currentElementName setString:@""];
        [self.queryResult.query.result addObject:dict];
        [self.queryResult.query.sortOrder addObject:sort];
    } else {
		if (self.currentElement) {
            if ([self.currentElementName isEqualToString:@"records"]) {
                if (![cmp isEqualToString:@"type"] &&
                    ![cmp isEqualToString:@"Id"]) {
                    
                    [dict setObject:self.currentElement forKey:cmp];
                    [sort addObject:cmp];
                }
            }
            self.currentElement = nil;
        }
    }
}

@end
