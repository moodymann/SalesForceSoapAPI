//
//  AppDelegate.h
//  Soap
//
//  Created by isid on 2015/03/11.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "InquiryService.h"
#import "MBWebServiceInfo.h"
#import "SObjects.h"
#import "SObject.h"
#import "WorkWindowController.h"

@interface AppDelegate : NSObject
<
NSApplicationDelegate,
InquiryServiceDelegate,
NSTableViewDataSource,
NSTableViewDelegate
>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *user;
@property (weak) IBOutlet NSSecureTextField *password;
@property (weak) IBOutlet NSTextField *loginStatusLabel;
@property (nonatomic, retain)WorkWindowController *workWindowController;

@end
