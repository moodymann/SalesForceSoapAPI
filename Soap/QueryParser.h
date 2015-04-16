//
//  QueryParser.h
//  Soap
//
//  Created by isid on 2015/04/06.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/tree.h>
#import "WebServiceLibxmlParser.h"
#import "QueryResult.h"

@interface QueryParser : WebServiceLibxmlParser
{
    NSMutableDictionary *dict;
    QueryResult *queryResult;
}

@property (nonatomic, retain)QueryResult *queryResult;

@end
