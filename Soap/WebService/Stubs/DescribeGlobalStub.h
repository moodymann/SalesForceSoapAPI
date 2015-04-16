//
//  DescribeGlobalStub.h
//  Soap
//
//  Created by isid on 2015/04/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceStubs.h"
#import "MBWebServiceInfo.h"
#import "DescribeGlobalParameter.h"
#import "DescribeGlobalResult.h"
#import "DescribrGlobalParser.h"

@interface DescribeGlobalStub : WebServiceStubs
{
    
    DescribrGlobalParser    *describrGlobalParser;
    DescribeGlobalResult    *describeGlobalResult;
}

@property (nonatomic, retain)DescribrGlobalParser    *describrGlobalParser;
@property (nonatomic, retain)DescribeGlobalResult    *describeGlobalResult;

- (void)searchAllObjects:(DescribeGlobalParameter *)parameter;

@end
