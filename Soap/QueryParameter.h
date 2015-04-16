//
//  QueryParameter.h
//  Soap
//
//  Created by isid on 2015/04/06.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceUtil.h"

@interface QueryParameter : NSObject
{
    NSString *queryString;
}

@property (nonatomic, retain)NSString *queryString;

- (NSString *)getSoapParameter;

@end
