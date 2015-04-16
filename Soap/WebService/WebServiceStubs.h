//
//  WebServiceStubs.h
//  Soap
//
//  Created by isid on 2015/03/11.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/tree.h>

/* ソープメッセージバージョン */
typedef enum {
    SoapVersion1_1,
	SoapVersion1_2
} WebServiceSoapVersion;

@interface WebServiceStubs : NSObject
{
@protected
    NSMutableData *webData;                                                     //  WebService返却データ
    int httpStatusCode;                                                         //  コネクション
    xmlParserCtxtPtr xmlParserContext;
    BOOL isConnectError;
    BOOL isAlreadyAlert;

//    NSURLAuthenticationChallenge    *myChallenge;

    BOOL isAuthPassed;
    NSDate *serviceConnectStartDate;
    NSDate *serviceReceiveStartDate;
}
@property (nonatomic, assign)BOOL isConnectError;
@property (nonatomic,retain)NSURLAuthenticationChallenge *myChallenge;

- (void)webServiceFailed:(NSNotification *)notification;
- (NSString *)makeSoapMessage:(NSString *)soapBody soapVersion:(WebServiceSoapVersion)soapVersion;
- (void)getDataForLibxml:(NSString *)endPointUrl
                 soapMsg:(NSString *)soapMsg
                 timeout:(NSTimeInterval)timeout
        xmlParserContext:(xmlParserCtxtPtr)parserContext
              soapAction:(NSString *)soapAction;

@end

#pragma mark - NSString category
/** HttpClientで利用するNSStringユーティリティカテゴリ
 */
@interface NSString (HttpClientStringUtility)
/** JavascirptのencodeURIComponent()相当を行うメソッド
 
 @return 変換済みNSStringオブジェクト
 */
- (NSString *)stringByEncodingURICompornent;

/** JavascirptのencodeURL()相当を行うメソッド
 
 @return 変換済みNSStringオブジェクト
 */
- (NSString *)stringByEncodingURL;

/** パーセントエンコードするメソッド
 
 @param chars エスケープする文字を指定
 @return 変換済みNSStringオブジェクト
 */
- (NSString *)stringByAddingPercentEscapesWithCharactersToBeEscaped:(NSString *)chars;

@end
