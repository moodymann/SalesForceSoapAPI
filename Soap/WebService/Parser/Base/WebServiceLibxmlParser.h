//
//  WebServiceLibxmlParser.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/tree.h>
#import "WebServiceResult.h"
@import ObjectiveC; //class_getProperty用

@interface WebServiceLibxmlParser : NSObject{
@private
	NSMutableString             *currentElementName;
	NSMutableString             *currentElement;
}

@property (nonatomic, retain)NSMutableString    *currentElementName;
@property (nonatomic, retain)NSMutableString    *currentElement;

+ (xmlSAXHandler)getXmlSAXHandler;

@end
