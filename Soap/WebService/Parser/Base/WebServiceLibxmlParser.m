//
//  WebServiceLibxmlParser.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "WebServiceLibxmlParser.h"

@interface WebServiceLibxmlParser(Private)

- (void)beforeStartElementLocalName:(const xmlChar *)localname
                             prefix:(const xmlChar *)prefix
                                URI:(const xmlChar *)URI
                      nb_namespaces:(int)nb_namespaces
                         namespaces:(const xmlChar **)namespaces
                      nb_attributes:(int)nb_attributes
                       nb_defaulted:(int)nb_defaulted
                         attributes:(const xmlChar **)attributes;
- (void)charactersFound:(const xmlChar *)ch len:(int)len;
- (void)beforeEndElementLocalName:(const xmlChar *)localname
                           prefix:(const xmlChar *)prefix
                              URI:(const xmlChar *)URI;

@end

static void startElementHandler(void *ctx,
                                const xmlChar *localname,
                                const xmlChar *prefix,
                                const xmlChar *URI,
                                int nb_namespaces,
                                const xmlChar **namespaces,
                                int nb_attributes,
                                int nb_defaulted,
                                const xmlChar **attributes) {
    [(__bridge WebServiceLibxmlParser *)ctx beforeStartElementLocalName:localname
                                                        prefix:prefix
                                                           URI:URI
                                                 nb_namespaces:nb_namespaces
                                                    namespaces:namespaces
                                                 nb_attributes:nb_attributes
                                                  nb_defaulted:nb_defaulted
                                                    attributes:attributes];
}

static void	charactersFoundHandler(void *ctx, const xmlChar *ch, int len)
{
    [(__bridge WebServiceLibxmlParser *)ctx charactersFound:ch len:len];
}

static void	endElementHandler(void *ctx , const xmlChar *localname, const xmlChar *prefix, const xmlChar *URI)
{
    [(__bridge WebServiceLibxmlParser *)ctx beforeEndElementLocalName:localname prefix:prefix URI:URI];
}

static xmlSAXHandler _saxHandlerCrosstabStruct =
{
    NULL,                                                                       //  internalSubset */
    NULL,                                                                       //  isStandalone   */
    NULL,                                                                       //  hasInternalSubset */
    NULL,                                                                       //  hasExternalSubset */
    NULL,                                                                       //  resolveEntity */
    NULL,                                                                       //  getEntity */
    NULL,                                                                       //  entityDecl */
    NULL,                                                                       //  notationDecl */
    NULL,                                                                       //  attributeDecl */
    NULL,                                                                       //  elementDecl */
    NULL,                                                                       //  unparsedEntityDecl */
    NULL,                                                                       //  setDocumentLocator */
    NULL,                                                                       //  startDocument */
    NULL,                                                                       //  endDocument */
    NULL,                                                                       //  startElement*/
    NULL,                                                                       //  endElement */
    NULL,                                                                       //  reference */
    charactersFoundHandler,                                                     //  characters */
    NULL,                                                                       //  ignorableWhitespace */
    NULL,                                                                       //  processingInstruction */
    NULL,                                                                       //  comment */
    NULL,                                                                       //  warning */
    NULL,                                                                       //  error */
    NULL,                                                                       //  fatalError //: unused error() get all the errors */
    NULL,                                                                       //  getParameterEntity */
    NULL,                                                                       //  cdataBlock */
    NULL,                                                                       //  externalSubset */
    XML_SAX2_MAGIC,                                                             //  initialized */
    NULL,                                                                       //  private */
    startElementHandler,                                                        //  startElementNs */
    endElementHandler,                                                          //  endElementNs */
    NULL,                                                                       //  serror */
};

@implementation WebServiceLibxmlParser

@synthesize currentElement;
@synthesize currentElementName;

/*******************************************************************************
 *  getXmlSAXHandler
 *
 */
+ (xmlSAXHandler)getXmlSAXHandler
{
    return _saxHandlerCrosstabStruct;
}
/*******************************************************************************
 *  init
 *
 */
- (id)init
{
    if ((self = [super init])) {
        currentElementName = [[NSMutableString alloc] initWithString:@""];
        currentElement = nil;
	}
	return self;
}

#pragma mark -- libxml handler --
/*******************************************************************************
 *  beforeStartElementLocalName
 *
 */
- (void)beforeStartElementLocalName:(const xmlChar *)localname
                             prefix:(const xmlChar *)prefix
                                URI:(const xmlChar *)URI
                      nb_namespaces:(int)nb_namespaces
                         namespaces:(const xmlChar **)namespaces
                      nb_attributes:(int)nb_attributes
                       nb_defaulted:(int)nb_defaulted
                         attributes:(const xmlChar **)attributes
{
    if (strncmp((char *)localname, "resultStatus", sizeof("resultStatus")) == 0) {
		[self.currentElementName setString:@""];
		[self.currentElementName appendString:[NSString stringWithUTF8String:(char *)localname]];
        self.currentElement = [[NSMutableString alloc] initWithString:@""];
    }else if (strncmp((char *)localname, "errorMessage", sizeof("errorMessage")) == 0) {
		[self.currentElementName setString:@""];
		[self.currentElementName appendString:[NSString stringWithUTF8String:(char *)localname]];
        self.currentElement = [[NSMutableString alloc] initWithString:@""];
    }
    [self startElementLocalName:localname
                         prefix:prefix
                            URI:URI
                  nb_namespaces:nb_namespaces
                     namespaces:namespaces
                  nb_attributes:nb_attributes
                   nb_defaulted:nb_defaulted
                     attributes:attributes];
}
/*******************************************************************************
 *  charactersFound
 *
 */
- (void)charactersFound:(const xmlChar *)ch len:(int)len
{
    // 文字列を追加する
    if (self.currentElement) {
        NSString *string = [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
        [self.currentElement appendString:string];
    }
}
/*******************************************************************************
 *  beforeEndElementLocalName
 *
 */
- (void)beforeEndElementLocalName:(const xmlChar *)localname
                           prefix:(const xmlChar *)prefix
                              URI:(const xmlChar *)URI
{
    if (self.currentElement) {
        WebServiceResult *result = [self getWebServiceResult];
		if ([self.currentElementName isEqualToString:@"resultStatus"]) {
            result.resultStatus = self.currentElement;
            self.currentElement = nil;
        }else if ([self.currentElementName isEqualToString:@"errorMessage"]) {
            result.errorMessage = self.currentElement;
            self.currentElement = nil;
        }
	}
    [self endElementLocalName:localname prefix:prefix URI:URI];
}

/*******************************************************************************
 *  getWebServiceResult
 *
 */
- (WebServiceResult *) getWebServiceResult
{
    return nil;
}
/*******************************************************************************
 *  startElementLocalName
 *
 */
- (void)startElementLocalName:(const xmlChar *)localname
                       prefix:(const xmlChar *)prefix
                          URI:(const xmlChar *)URI
                nb_namespaces:(int)nb_namespaces
                   namespaces:(const xmlChar **)namespaces
                nb_attributes:(int)nb_attributes
                 nb_defaulted:(int)nb_defaulted
                   attributes:(const xmlChar **)attributes
{
}
/*******************************************************************************
 *  endElementLocalName
 *
 */
- (void)endElementLocalName:(const xmlChar *)localname
                     prefix:(const xmlChar *)prefix
                        URI:(const xmlChar *)URI
{
    if (self.currentElement) {
        self.currentElement = nil;
	}
}

@end
