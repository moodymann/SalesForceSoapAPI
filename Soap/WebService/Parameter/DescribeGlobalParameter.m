//
//  DescribeGlobalParameter.m
//  Soap
//
//  Created by isid on 2015/04/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "DescribeGlobalParameter.h"

@implementation DescribeGlobalParameter
/*******************************************************************************
 *  init
 *  初期処理
 */
- (id)init
{
    if ((self = [super init])) {
        
    }
	return self;
}

/*******************************************************************************
 *  getSoapParameter
 *
 */
- (NSString *)getSoapParameter
{
	NSMutableString *soapParam = [[NSMutableString alloc] init];
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  オブジェクト名
    [WebServiceUtil appendStringParameterElementWithSoapparam:soapParam key:@"urn:describeGlobal" value:@""];
    
	return soapParam;
}

@end
