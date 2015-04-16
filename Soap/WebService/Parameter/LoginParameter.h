//
//  LoginParameter.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceUtil.h"

@interface LoginParameter : NSObject
{
    NSString    *userId;                                                        //  ユーザーID
    NSString    *password;                                                      //  パスワード
}

@property (nonatomic, retain)NSString   *userId;
@property (nonatomic, retain)NSString   *password;

- (NSString *)getSoapParameter;
@end
