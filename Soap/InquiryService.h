//
//  InquiryService.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserVO.h"
#import "SObjects.h"
#import "Query.h"

@class InquiryService;

@protocol InquiryServiceDelegate<NSObject>
@optional
- (void)loginRes;
- (void)searchDone;
- (void)queryDone;
- (void)searchAllObjectsDone;
@end

@interface InquiryService : NSObject
{

    BOOL                                isLogined;
    UserVO                              *userVo;
    Query             *query;
    NSMutableArray    *sObjects;
    NSMutableArray  *objectList;

}
@property (nonatomic, assign)id<InquiryServiceDelegate>     inquiryServiceDelegate;
@property (nonatomic, assign)BOOL            isLogined;
@property (nonatomic, retain)UserVO                         *userVo;
@property (nonatomic, retain)Query             *query;
@property (nonatomic, retain)NSMutableArray    *sObjects;
@property (nonatomic, retain)NSMutableArray  *objectList;

+ (InquiryService *)sharedInstance;

- (void) loginInquiry:(NSString *)userId
             password:(NSString *)password;
- (void)loginInquiryStart:(NSString *)userId
                 password:(NSString *)password;
- (void)loginInquiryEnd:(NSNotification *)notification;

- (void)searchSObject:(NSString *)objectName;
- (void)searchSObjectStart:(NSString *)objectName;
- (void)searchSObjectEnd:(NSNotification *)notification;

- (void)execQuery:(NSString *)queryString;

- (void)searchAllObjects;
- (void)searchAllObjectsStart;
- (void)searchAllObjectsEnd:(NSNotification *)notification;

@end
