//
//  LoginResult.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceResult.h"
#import "UserVO.h"

@interface LoginResult : WebServiceResult
{
@private
    UserVO  *userVO;                                            //  ユーザ情報
}

@property (nonatomic, retain)UserVO *userVO;

@end
