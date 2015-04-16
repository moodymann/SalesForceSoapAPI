//
//  QueryServiceStub.h
//  Soap
//
//  Created by isid on 2015/04/06.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceStubs.h"
#import "QueryParameter.h"
#import "QueryParser.h"
#import "QueryResult.h"
#import "MBWebServiceInfo.h"

@interface QueryServiceStub : WebServiceStubs
{
@private
    QueryParser          *queryParser;
	QueryResult          *queryResult;
}

@property (nonatomic, retain)QueryParser         *queryParser;
@property (nonatomic, retain)QueryResult         *queryResult;

- (void)execQuery:(QueryParameter *)parameter;

@end
