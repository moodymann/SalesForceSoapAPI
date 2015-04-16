//
//  LoginLibxmlParser.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "LoginLibxmlParser.h"
#import "WebServiceUtil.h"

@implementation LoginLibxmlParser

@synthesize loginResult;

/*******************************************************************************
 *  init
 *
 */
- (id)init
{
    if ((self = [super init])) {
        self.loginResult = [[LoginResult alloc]init];
        self.loginResult.userVO = [[UserVO alloc] init];
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
    return self.loginResult;
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
    if (strncmp((char *)localname, "result", sizeof("result")) == 0) {
		[self.currentElementName setString:@""];
		[self.currentElementName appendString:[NSString stringWithUTF8String:(char *)localname]];
    }
	if ([self.currentElementName isEqualToString:@"result"]) {
		if (self.loginResult.userVO) {
			if (class_getProperty([self.loginResult.userVO class], (char *)localname)) {
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
    if (strncmp((char *)localname, "result", sizeof("result")) == 0) {
		[self.currentElementName setString:@""];
    } else {
		if (self.currentElement) {
            if ([self.currentElementName isEqualToString:@"result"]) {
                [self.loginResult.userVO setValue:self.currentElement forKey:[NSString stringWithUTF8String:(char *)localname]];
            }
            self.currentElement = nil;
		}
	}
}

@end
