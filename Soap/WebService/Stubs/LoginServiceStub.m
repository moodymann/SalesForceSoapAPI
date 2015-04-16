//
//  LoginServiceStub.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "LoginServiceStub.h"
#import "MBWebServiceInfo.h"

@implementation LoginServiceStub

@synthesize loginLibxmlParser;
@synthesize loginResult;

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
- (void)login:(LoginParameter *)parameter
{
    //--------------------------------------------------------------------------
    //  通信パラメータ作成
	NSMutableString *soapBody = [[NSMutableString alloc]init];
	[soapBody appendString:@"<soap:Body>"];
	[soapBody appendString:@"<urn:login>"];
	[soapBody appendString:[parameter getSoapParameter]];
	[soapBody appendString:@"</urn:login>"];
	[soapBody appendString:@"</soap:Body>"];
	NSString *soapMsg = [super makeSoapMessage:soapBody soapVersion:SoapVersion1_1];

    //--------------------------------------------------------------------------
    //  通知要求の登録
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginDone:) name:@"connectionDidFinishNotification" object:self];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webServiceFailed:) name:@"connectionDidFailWithError" object:self];
    //--------------------------------------------------------------------------
    //  通信開始
    self.loginLibxmlParser = [[LoginLibxmlParser alloc] init];
    //--------------------------------------------------------------------------
    //  下の解放はsuperクラスで行うのでこちらではやらなくていい
    xmlSAXHandler handler = [LoginLibxmlParser getXmlSAXHandler];
    xmlParserCtxtPtr parser = xmlCreatePushParserCtxt(&handler, (__bridge void *)(self.loginLibxmlParser), NULL, 0, NULL);
    [super getDataForLibxml:[MBWebServiceInfo getLoginServiceURL]
                    soapMsg:soapMsg
                    timeout:[MBWebServiceInfo getLoginServiceTimeout]
           xmlParserContext:parser
            soapAction:@"login"];
}

/*******************************************************************************
 *  loginDone
 *
 */
- (void)loginDone:(NSNotification *)notification
{
    //--------------------------------------------------------------------------
    //  通知要求を削除
	[[NSNotificationCenter defaultCenter]removeObserver:self name:@"connectionDidFinishNotification" object:self];
	[[NSNotificationCenter defaultCenter]removeObserver:self name:@"connectionDidFailWithError" object:self];
    //--------------------------------------------------------------------------
    //  通信結果取得
    self.loginResult = loginLibxmlParser.loginResult;
    //--------------------------------------------------------------------------
    //  通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginEnd" object:self];
}

@end
