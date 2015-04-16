//
//  DescribrGlobalParser.m
//  Soap
//
//  Created by isid on 2015/04/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "DescribrGlobalParser.h"

@implementation DescribrGlobalParser

@synthesize describeResult;
/*******************************************************************************
 *  init
 *
 */
- (id)init
{
    if ((self = [super init])) {
        self.describeResult = [[DescribeGlobalResult alloc] init];
        self.describeResult.objectList = [[NSMutableArray alloc] init];
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
    return self.describeResult;
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
    }else if ([cmp isEqualToString:@"sobjects"]){
		[self.currentElementName setString:@""];
		[self.currentElementName appendString:cmp];
        sObject = [[SObject alloc] init];
    }

	if ([self.currentElementName isEqualToString:@"types"]) {
            self.currentElement = [[NSMutableString alloc] initWithString:@""];
    }else if ([self.currentElementName isEqualToString:@"sobjects"]){
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
    
    if ([cmp isEqualToString:@"sobjects"]) {
		[self.currentElementName setString:@""];
        [self.describeResult.objectList addObject:sObject];
    } else {
		if (self.currentElement) {
            if ([self.currentElementName isEqualToString:@"sobjects"]) {
                [sObject setValue:self.currentElement forKey:cmp];
            }
            self.currentElement = nil;
        }
    }

}

@end
