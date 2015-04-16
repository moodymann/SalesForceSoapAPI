//
//  BaseMasterVO.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "BaseMasterVO.h"

@implementation BaseMasterVO

@synthesize validFlag;                                      //  有効フラグ
@synthesize createUserId;                                   //  作成者ID
@synthesize createDate;                                     //  作成日
@synthesize updateUserId;                                   //  更新者ID
@synthesize updateDate;                                     //  更新日時
@synthesize updateType;                                     //  更新種別


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
