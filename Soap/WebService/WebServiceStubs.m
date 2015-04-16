//
//  WebServiceStubs.m
//  Soap
//
//  Created by isid on 2015/03/11.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "WebServiceStubs.h"
#import "MBWebServiceInfo.h"


@implementation WebServiceStubs

@synthesize isConnectError;

/*******************************************************************************
 *  init
 *  初期処理
 */
- (id)init
{
    if ((self = [super init])) {
        isConnectError = NO;
        serviceConnectStartDate = nil;
        serviceReceiveStartDate = nil;
    }
	return self;
}

/*******************************************************************************
 *  makeSoapMessage
 *  ソープメッセージを作成し、返却します。
 */
- (NSString *)makeSoapMessage:(NSString *)soapBody soapVersion:(WebServiceSoapVersion)soapVersion
{
	NSString *soapMsg;
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  SOAP1.1
	if (soapVersion == SoapVersion1_1) {
		soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
				   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:partner.soap.sforce.com\">"                   
				   "%@"
				   "</soap:Envelope>", soapBody];
        
        //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
        //  SOAP1.2
	} else if (soapVersion == SoapVersion1_2) {
		soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
				   "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
				   "<soap12:Body>"
				   "%@"
				   "</soap12:Body>"
				   "</soap12:Envelope>", soapBody];
        //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
        //
	} else {
        soapMsg = @"";
    }
	
	return soapMsg;
}

/*******************************************************************************
 *  getDataForLibxml
 *  WebService呼び出し実行（POST）
 *  xmlパーサがlibxml版
 */
- (void)getDataForLibxml:(NSString *)endPointUrl
                 soapMsg:(NSString *)soapMsg
                 timeout:(NSTimeInterval)timeout
        xmlParserContext:(xmlParserCtxtPtr)parserContext
              soapAction:(NSString *)soapAction
{
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    // デバッグログ
#ifdef DEBUG
	NSLog(@"SoapMsg:%@", soapMsg);
#endif
    xmlParserContext = parserContext;
    //  リクエスト作成
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:endPointUrl]
                                                       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                   timeoutInterval:timeout];
    req.HTTPShouldHandleCookies = NO;
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
	//---set the headers---
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
	[req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
	//---set the HTTP method and body---
	[req setHTTPMethod:@"POST"];
	[req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSDictionary *cookieHeader = [self createCookie];
//    if (cookieHeader) {
//        [req setAllHTTPHeaderFields:cookieHeader];
//    }
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];

    if(!conn){
        NSLog(@"failed:");
    }
}

/*******************************************************************************
 *  makeSendCookie
 *  クッキーが必要な場合に記述する。
 */
- (NSDictionary *)createCookie
{
    NSMutableArray *cookies = [NSMutableArray array];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSHTTPCookie *makeCookie;

    
    [cookies addObject:[[NSHTTPCookie alloc] initWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:@"obj", @"key", nil]]];
    
    [storage setCookie:makeCookie];
    
    if (cookies.count > 0) {
        return [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    }
    return nil;
}

/*******************************************************************************
 *  webServiceFailed
 *
 */
- (void)webServiceFailed:(NSNotification *)notification
{
    isConnectError = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"connectionDidFinishNotification" object:self];
}
/*******************************************************************************
 *
 *  NSURLConnectionデリゲート用実装
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    serviceReceiveStartDate = [NSDate date];
    if (!xmlParserContext) {
        [webData setLength: 0];
    }
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  HTTPStatusCodeを取得
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    httpStatusCode = (int)[resp statusCode];
}

/*******************************************************************************
 *  connection:didReceiveData
 *  NSURLConnectionデリゲート用実装
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (xmlParserContext) {
        xmlParseChunk(xmlParserContext, (const char*)[data bytes], (int)[data length], 0);
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    } else {
        [webData appendData:data];
    }
}
/*******************************************************************************
 *  connection:didFailWithError
 *  NSURLConnectionデリゲート用実装
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  XMLパーサを解放する
    if (xmlParserContext) {
        xmlFreeParserCtxt(xmlParserContext), xmlParserContext = NULL;
    }
	[[NSNotificationCenter defaultCenter]postNotificationName:@"connectionDidFailWithError" object:self];
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  connectionError
    NSLog(@"ConnectionError：%@", [error localizedDescription]);
}
/*******************************************************************************
 *  connectionDidFinishLoading
 *  NSURLConnectionデリゲート用実装
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (xmlParserContext) {
        //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
        //  データを追加する
        xmlParseChunk(xmlParserContext, NULL, 0, 1);
        //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
        //  XMLパーサを解放する
        xmlFreeParserCtxt(xmlParserContext), xmlParserContext = NULL;
    } else {

    }
    if (httpStatusCode >= 400) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"connectionDidFailWithError" object:self];
        NSLog(@"HTTPStatusError：%i", httpStatusCode);
    } else {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"connectionDidFinishNotification" object:self];
    }
}

@end
