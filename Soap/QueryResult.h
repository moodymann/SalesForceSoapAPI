//
//  QueryResult.h
//  Soap
//
//  Created by isid on 2015/04/06.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceResult.h"
#import "Query.h"

@interface QueryResult : WebServiceResult
{
    Query *query;
}

@property (nonatomic, retain)Query *query;

@end
