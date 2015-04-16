//
//  UserVO.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "UserVO.h"

@implementation UserVO

@synthesize userId;                                                 //  ユーザID
@synthesize userName;                                               //  ユーザ名称
@synthesize userFullName;                                               //  ユーザ名称
@synthesize usereMail;                                           //  ユーザ名称カナ
@synthesize authority;                                              //  権限
@synthesize serverUrl;
@synthesize metadataServerUrl;
@synthesize sessionId;
@synthesize passwordExpired;
@synthesize sandbox;
@synthesize organizationId;

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
