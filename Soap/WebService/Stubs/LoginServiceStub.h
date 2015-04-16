//
//  LoginServiceStub.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceStubs.h"
#import "LoginParameter.h"
#import "LoginLibxmlParser.h"
#import "LoginResult.h"

@interface LoginServiceStub : WebServiceStubs
{
@private
    LoginLibxmlParser          *loginLibxmlParser;
	LoginResult                *loginResult;
}

@property (nonatomic, retain)LoginLibxmlParser         *loginLibxmlParser;
@property (nonatomic, retain)LoginResult           *loginResult;

- (void)login:(LoginParameter *)parameter;


@end
