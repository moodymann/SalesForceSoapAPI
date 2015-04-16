//
//  UserVO.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "BaseMasterVO.h"

@interface UserVO : BaseMasterVO
{
@private
    NSString            *userId;                                        //  ユーザID
    NSString            *userName;                                      //  ユーザ名称
    NSString            *userFullName;                                      //  ユーザ名称
    NSString            *usereMail;                                  //  ユーザ名称カナ
    NSString            *authority;                                     //  権限
    NSString            *serverUrl;
    NSString            *metadataServerUrl;
    NSString            *sessionId;
    NSString            *passwordExpired;
    NSString            *sandbox;
    NSString            *organizationId;
    
}

@property (nonatomic, retain)NSString            *userId;
@property (nonatomic, retain)NSString            *userName;
@property (nonatomic, retain)NSString            *userFullName;
@property (nonatomic, retain)NSString            *usereMail;
@property (nonatomic, retain)NSString            *authority;
@property (nonatomic, retain)NSString            *serverUrl;
@property (nonatomic, retain)NSString            *metadataServerUrl;
@property (nonatomic, retain)NSString            *sessionId;
@property (nonatomic, retain)NSString            *passwordExpired;
@property (nonatomic, retain)NSString            *sandbox;
@property (nonatomic, retain)NSString            *organizationId;

@end
