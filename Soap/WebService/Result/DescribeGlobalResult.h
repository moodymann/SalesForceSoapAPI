//
//  DescribeGlobalResult.h
//  Soap
//
//  Created by isid on 2015/04/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceResult.h"

@interface DescribeGlobalResult : WebServiceResult
{
    NSMutableArray *objectList;
}

@property (nonatomic, retain) NSMutableArray *objectList;

@end
