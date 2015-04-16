//
//  InquiryService.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "InquiryService.h"
#import "LoginServiceStub.h"
#import "DescribeSObjectsServiceStub.h"
#import "QueryServiceStub.h"
#import "DescribeGlobalStub.h"

@implementation InquiryService

@synthesize inquiryServiceDelegate;
@synthesize isLogined;
@synthesize userVo;
@synthesize sObjects;
@synthesize query;
@synthesize objectList;

/*******************************************************************************
 *  sharedInstance
 *  自身のインスタンスを返却
 */
+ (InquiryService *)sharedInstance
{
	static InquiryService *sharedInstance;
	
	@synchronized(self)
	{
		if (!sharedInstance) {
			sharedInstance = [[InquiryService alloc] init];
        }
		return sharedInstance;
	}
}

- (id)init{
    if ((self = [super init])) {
    }
    return self;
}
/*******************************************************************************
 *  loginInquiry
 *
 */
- (void) loginInquiry:(NSString *)userId
                 password:(NSString *)password{
    //--------------------------------------------------------------------------

    [self loginInquiryStart:userId password:password];
}

/*******************************************************************************
 *  loginInquiryStart
 *
 */
- (void)loginInquiryStart:(NSString *)userId
                     password:(NSString *)password
{
    //--------------------------------------------------------------------------
    //  通知要求の登録
    LoginServiceStub *service = [[LoginServiceStub alloc]init];
	[[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(loginInquiryEnd:)
                                                name:@"loginEnd"
                                              object:service];
    
    LoginParameter *param = [[LoginParameter alloc]init];
    param.userId = userId;
    param.password = password;
    [service login:param];
    
    /* クッキー作成用にパスワードをバイナリ保存 */
//    self.passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
}
/*******************************************************************************
 *  LoginInquiryEnd
 *
 */
- (void)loginInquiryEnd:(NSNotification *)notification
{
    //--------------------------------------------------------------------------
    //  通知要求を削除
    LoginServiceStub *service = (LoginServiceStub *)[notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"loginEnd"
                                                  object:service];
    //--------------------------------------------------------------------------
    if( service.loginResult != nil ) {                              //  読み込めた場合
        NSLog(@"%@", service.loginResult.resultStatus);
        if ( !service.loginResult.resultStatus ) {
            self.isLogined = YES;
            self.userVo = service.loginResult.userVO;
        } else {
            self.isLogined = NO;
        }
    } else {
        self.isLogined = NO;
    }
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    [self.inquiryServiceDelegate loginRes];
}

/*******************************************************************************
 *  searchSObject
 *
 */
- (void)searchSObject:(NSString *)objectName
{
    //--------------------------------------------------------------------------
    [self searchSObjectStart:objectName];
}

/*******************************************************************************
 *  searchSObjectStart
 *
 */
- (void)searchSObjectStart:(NSString *)objectName
{
    //--------------------------------------------------------------------------
    //  通知要求の登録
    DescribeSObjectsServiceStub *service = [[DescribeSObjectsServiceStub alloc] init];
	[[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(searchSObjectEnd:)
                                                name:@"searchEnd"
                                              object:service];
    
    DescribeSObjectParameter *param = [[DescribeSObjectParameter alloc] init];
    param.sObject = objectName;
    [service searchSObject:param];
    
}

/*******************************************************************************
 *  searchSObjectEnd
 *
 */
- (void)searchSObjectEnd:(NSNotification *)notification
{
    //--------------------------------------------------------------------------
    //  通知要求を削除
    DescribeSObjectsServiceStub *service = (DescribeSObjectsServiceStub *)[notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"searchEnd"
                                                  object:service];
    //--------------------------------------------------------------------------
    if( service.deescribeSObjectsSearchResult.sObjects != nil ) {
        self.sObjects = service.deescribeSObjectsSearchResult.sObjects;
    }
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    [self.inquiryServiceDelegate searchDone];
}

/*******************************************************************************
 *  searchSObject
 *
 */
- (void)execQuery:(NSString *)queryString
{
    //--------------------------------------------------------------------------
    [self execQueryStart:queryString];
}

/*******************************************************************************
 *  searchSObjectStart
 *
 */
- (void)execQueryStart:(NSString *)queryString
{
    //--------------------------------------------------------------------------
    //  通知要求の登録
    QueryServiceStub *service = [[QueryServiceStub alloc] init];
	[[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(execQueryEnd:)
                                                name:@"execQueryEnd"
                                              object:service];
    
    QueryParameter *param = [[QueryParameter alloc] init];
    param.queryString = queryString;
    [service execQuery:param];
    
}

/*******************************************************************************
 *  searchSObjectEnd
 *
 */
- (void)execQueryEnd:(NSNotification *)notification
{
    //--------------------------------------------------------------------------
    //  通知要求を削除
    QueryServiceStub *service = (QueryServiceStub *)[notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"execQueryEnd"
                                                  object:service];
    //--------------------------------------------------------------------------
    if( service.queryResult.query != nil ) {
        self.query = service.queryResult.query;
    }
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    [self.inquiryServiceDelegate queryDone];
}

/*******************************************************************************
 *  searchSObject
 *
 */
- (void)searchAllObjects
{
    //--------------------------------------------------------------------------
    [self searchAllObjectsStart];
}

/*******************************************************************************
 *  searchSObjectStart
 *
 */
- (void)searchAllObjectsStart
{
    //--------------------------------------------------------------------------
    //  通知要求の登録
    DescribeGlobalStub *service = [[DescribeGlobalStub alloc] init];
	[[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(searchAllObjectsEnd:)
                                                name:@"searchAllObjectsEnd"
                                              object:service];
    
    DescribeGlobalParameter *param = [[DescribeGlobalParameter alloc] init];
    [service searchAllObjects:param];
    
}

/*******************************************************************************
 *  searchSObjectEnd
 *
 */
- (void)searchAllObjectsEnd:(NSNotification *)notification
{
    //--------------------------------------------------------------------------
    //  通知要求を削除
    DescribeGlobalStub *service = (DescribeGlobalStub *)[notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"searchAllObjectsEnd"
                                                  object:service];
    //--------------------------------------------------------------------------
    if( service.describeGlobalResult.objectList != nil ) {
        self.objectList = [[NSMutableArray alloc] init];
        for (SObject *obj in service.describeGlobalResult.objectList) {
            if ([obj.custom isEqualToString:@"true"]) {
                [self.objectList addObject:obj];
            }
        }
    }
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    [self.inquiryServiceDelegate searchAllObjectsDone];
}
@end
