//
//  DescribeGlobalStub.m
//  Soap
//
//  Created by isid on 2015/04/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "DescribeGlobalStub.h"
#import "WebServiceUtil.h"
#import "InquiryService.h"

@implementation DescribeGlobalStub

@synthesize describeGlobalResult;
@synthesize describrGlobalParser;

/*******************************************************************************
 *  init
 *  初期処理
 */
-(id)init
{
	return self = [super init];
}

/*******************************************************************************
 *  customerInfoSearch
 *
 */
- (void)searchAllObjects:(DescribeGlobalParameter *)parameter
{
    //--------------------------------------------------------------------------
    //  通信パラメータ作成
	NSMutableString *soapBody = [[NSMutableString alloc]init];
    [WebServiceUtil appendSessionHeader:soapBody sessionHeader:[[[InquiryService sharedInstance] userVo] sessionId]];
	[soapBody appendString:@"<soap:Body>"];
	[soapBody appendString:@"<urn:describeGlobal>"];
//	[soapBody appendString:[parameter getSoapParameter]];
	[soapBody appendString:@"</urn:describeGlobal>"];
	[soapBody appendString:@"</soap:Body>"];
	NSString *soapMsg = [super makeSoapMessage:soapBody soapVersion:SoapVersion1_1];
    
    //--------------------------------------------------------------------------
    //  通知要求の登録
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchAllObjectsDone:) name:@"connectionDidFinishNotification" object:self];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webServiceFailed:) name:@"connectionDidFailWithError" object:self];
    //--------------------------------------------------------------------------
    //  通信開始
    self.describrGlobalParser= [[DescribrGlobalParser alloc] init];
    //--------------------------------------------------------------------------
    //  下の解放はsuperクラスで行うのでこちらではやらなくていい
    xmlSAXHandler handler = [DescribrGlobalParser getXmlSAXHandler];
    xmlParserCtxtPtr parser = xmlCreatePushParserCtxt(&handler, (__bridge void *)(self.describrGlobalParser), NULL, 0, NULL);
    [super getDataForLibxml:[InquiryService sharedInstance].userVo.serverUrl
                    soapMsg:soapMsg
                    timeout:[MBWebServiceInfo getLoginServiceTimeout]
           xmlParserContext:parser
                 soapAction:@"describeGlobal"];
}

/*******************************************************************************
 *  loginDone
 *
 */
- (void)searchAllObjectsDone:(NSNotification *)notification
{
    //--------------------------------------------------------------------------
    //  通知要求を削除
	[[NSNotificationCenter defaultCenter]removeObserver:self name:@"connectionDidFinishNotification" object:self];
	[[NSNotificationCenter defaultCenter]removeObserver:self name:@"connectionDidFailWithError" object:self];
    //--------------------------------------------------------------------------
    //  通信結果取得
    self.describeGlobalResult = self.describrGlobalParser.describeResult;
    //--------------------------------------------------------------------------
    //  通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"searchAllObjectsEnd" object:self];
}

@end
