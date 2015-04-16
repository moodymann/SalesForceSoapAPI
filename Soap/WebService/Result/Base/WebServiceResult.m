//
//  WebServiceResult.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "WebServiceResult.h"

@implementation WebServiceResult

@synthesize resultStatus;                                                       //  実行結果
@synthesize errorMessage;                                                       //  エラーメッセージ

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

@end
