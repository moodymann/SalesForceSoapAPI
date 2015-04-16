//
//  DescribeSObjectParameter.h
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceUtil.h"

@interface DescribeSObjectParameter : NSObject
{
    NSString *sObject;
}

@property (nonatomic, retain)NSString   *sObject;

- (NSString *)getSoapParameter;

@end
