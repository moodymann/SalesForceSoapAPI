//
//  DescribrGlobalParser.h
//  Soap
//
//  Created by isid on 2015/04/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/tree.h>
#import "WebServiceLibxmlParser.h"
#import "DescribeGlobalResult.h"
#import "SObject.h"

@interface DescribrGlobalParser : WebServiceLibxmlParser
{
    DescribeGlobalResult *describeResult;
    
    NSMutableArray *sObjects;
    SObject *sObject;
}

@property (nonatomic, retain) DescribeGlobalResult *describeResult;

@end
