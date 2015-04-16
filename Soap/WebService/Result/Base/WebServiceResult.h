//
//  WebServiceResult.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceResult : NSObject
{
@private
    NSString        *resultStatus;                                              //  実行結果
    NSString        *errorMessage;                                              //  エラーメッセージ
}

@property (nonatomic, retain)NSString       *resultStatus;
@property (nonatomic, retain)NSString       *errorMessage;

@end
