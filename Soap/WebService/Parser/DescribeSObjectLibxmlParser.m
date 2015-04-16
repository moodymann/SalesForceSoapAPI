//
//  DescribeSObjectLibxmlParser.m
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "DescribeSObjectLibxmlParser.h"

@implementation DescribeSObjectLibxmlParser

@synthesize describesObjectsSearchResult;


/*******************************************************************************
 *  init
 *
 */
- (id)init
{
    if ((self = [super init])) {
        self.describesObjectsSearchResult = [[DescribeSObjectsSearchResult alloc] init];
        self.describesObjectsSearchResult.sObjects = [[NSMutableArray alloc] init];
        sObjects = [[NSMutableArray alloc]init];
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
    return self.describesObjectsSearchResult;
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
    }else if([cmp isEqualToString:@"result"]) {
		[self.currentElementName setString:@""];
		[self.currentElementName appendString:[NSString stringWithUTF8String:(char *)localname]];
        sObjects = [NSMutableArray array];
    }else if ([cmp isEqualToString:@"fields"]){
		[self.currentElementName setString:@""];
		[self.currentElementName appendString:cmp];
        sObject = [[SObject alloc] init];
        [sObjects addObject:sObject];
    }
	if ([self.currentElementName isEqualToString:@"limit"]) {
        if (class_getProperty([self.describesObjectsSearchResult class], (char *)localname)) {
            self.currentElement = [[NSMutableString alloc] initWithString:@""];
		}
    }else if ([self.currentElementName isEqualToString:@"result"]) {
        if (class_getProperty([sObjects class], (char *)localname)) {
            self.currentElement = [[NSMutableString alloc] initWithString:@""];
		}
    }else if ([self.currentElementName isEqualToString:@"fields"]){
        if (sObject) {
            if (class_getProperty([sObject class], (char *)localname)) {
				self.currentElement = [[NSMutableString alloc] initWithString:@""];
			}
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
    
    if ([cmp isEqualToString:@"fields"]) {
		[self.currentElementName setString:@""];
        [self.describesObjectsSearchResult.sObjects addObject:sObject];
    } else {
		if (self.currentElement) {
            if ([self.currentElementName isEqualToString:@"fields"]) {
                [sObject setValue:self.currentElement forKey:cmp];
            }
            self.currentElement = nil;
        }
    }
}
@end
