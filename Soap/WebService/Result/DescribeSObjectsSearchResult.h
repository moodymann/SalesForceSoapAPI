//
//  SObjectsSearchResult.h
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceResult.h"
#import "SObjects.h"

@interface DescribeSObjectsSearchResult : WebServiceResult
{
    NSMutableArray *sObjects;
}

@property(nonatomic, retain)NSMutableArray *sObjects;

@end
