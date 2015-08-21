//
//  DescribeSObjectLibxmlParser.h
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/tree.h>
#import "WebServiceLibxmlParser.h"
#import "DescribeSObjectsSearchResult.h"
#import "SObject.h"
#import "PickListValues.h"

@interface DescribeSObjectLibxmlParser : WebServiceLibxmlParser
{
    DescribeSObjectsSearchResult     *describesObjectsSearchResult;

    NSMutableArray *sObjects;
    SObject *sObject;
    PickListValues *pickListValues;
}

@property (nonatomic, retain)DescribeSObjectsSearchResult     *describesObjectsSearchResult;

@end
