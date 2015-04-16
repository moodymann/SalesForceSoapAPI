//
//  LoginLibxmlParser.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/tree.h>
#import "WebServiceLibxmlParser.h"
#import "LoginResult.h"
#import "UserVO.h"

@interface LoginLibxmlParser : WebServiceLibxmlParser
{
@private
    LoginResult             *loginResult;
}

@property (nonatomic, retain)LoginResult *loginResult;

@end
