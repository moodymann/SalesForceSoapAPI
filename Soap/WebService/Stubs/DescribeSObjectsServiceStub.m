//
//  SObjectsServiceStub.m
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "DescribeSObjectsServiceStub.h"
#import "MBWebServiceInfo.h"
#import "WebServiceUtil.h"
#import "InquiryService.h"

@implementation DescribeSObjectsServiceStub

@synthesize deescribeSObjectsSearchResult;
@synthesize describeSObjectLibxmlParser;

/*******************************************************************************
 *  init
 *  初期処理
 */
-(id)init
{
	return self = [super init];
}

- (void)searchSObject:(DescribeSObjectParameter *)parameter
{
    //--------------------------------------------------------------------------
    //  通信パラメータ作成
	NSMutableString *soapBody = [[NSMutableString alloc]init];
    
    [WebServiceUtil appendSessionHeader:soapBody sessionHeader:[[[InquiryService sharedInstance] userVo] sessionId]];
	[soapBody appendString:@"<soap:Body>"];
	[soapBody appendString:@"<urn:describeSObject>"];
	[soapBody appendString:[parameter getSoapParameter]];
	[soapBody appendString:@"</urn:describeSObject>"];
	[soapBody appendString:@"</soap:Body>"];
	NSString *soapMsg = [super makeSoapMessage:soapBody soapVersion:SoapVersion1_1];
    
    //--------------------------------------------------------------------------
    //  通知要求の登録
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchSObjectEnd:) name:@"connectionDidFinishNotification" object:self];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webServiceFailed:) name:@"connectionDidFailWithError" object:self];
    //--------------------------------------------------------------------------
    //  通信開始
    self.describeSObjectLibxmlParser = [[DescribeSObjectLibxmlParser alloc] init];
    //--------------------------------------------------------------------------
    //  下の解放はsuperクラスで行うのでこちらではやらなくていい
    xmlSAXHandler handler = [DescribeSObjectLibxmlParser getXmlSAXHandler];
    xmlParserCtxtPtr parser = xmlCreatePushParserCtxt(&handler, (__bridge void *)(self.describeSObjectLibxmlParser), NULL, 0, NULL);
    [super getDataForLibxml:[InquiryService sharedInstance].userVo.serverUrl
                    soapMsg:soapMsg
                    timeout:[MBWebServiceInfo getLoginServiceTimeout]
           xmlParserContext:parser
                 soapAction:@"describeSObject"];
    
}

/*******************************************************************************
 *  searchSObjectEnd
 *
 */
- (void)searchSObjectEnd:(NSNotification *)notification
{
    //--------------------------------------------------------------------------
    //  通知要求を削除
	[[NSNotificationCenter defaultCenter]removeObserver:self name:@"connectionDidFinishNotification" object:self];
	[[NSNotificationCenter defaultCenter]removeObserver:self name:@"connectionDidFailWithError" object:self];
    //--------------------------------------------------------------------------
    //  通信結果取得
    self.deescribeSObjectsSearchResult = describeSObjectLibxmlParser.describesObjectsSearchResult;
    //--------------------------------------------------------------------------
    //  通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"searchEnd" object:self];
}

@end
