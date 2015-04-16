//
//  SObjectsServiceStub.h
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceStubs.h"
#import "DescribeSObjectLibxmlParser.h"
#import "DescribeSObjectParameter.h"
#import "DescribeSObjectsSearchResult.h"

@interface DescribeSObjectsServiceStub : WebServiceStubs
{
    @private
    DescribeSObjectLibxmlParser          *describeSObjectLibxmlParser;
    DescribeSObjectsSearchResult         *deescribeSObjectsSearchResult;
}

@property (nonatomic, retain)DescribeSObjectLibxmlParser    *describeSObjectLibxmlParser;
@property (nonatomic, retain)DescribeSObjectsSearchResult   *deescribeSObjectsSearchResult;

- (void)searchSObject:(DescribeSObjectParameter *)parameter;

@end
