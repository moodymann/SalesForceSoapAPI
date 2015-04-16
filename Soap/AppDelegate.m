//
//  AppDelegate.m
//  Soap
//
//  Created by isid on 2015/03/11.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize user;
@synthesize password;
@synthesize workWindowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [MBWebServiceInfo initWith];
    [InquiryService sharedInstance].inquiryServiceDelegate = self;

    user.stringValue = [MBWebServiceInfo getUserName];
    password.stringValue = [MBWebServiceInfo getPassWord];
    
}

- (IBAction)pushButton:(id)sender {
    [[InquiryService sharedInstance] loginInquiry:user.stringValue
                                         password:password.stringValue];
}

#pragma --mark InquiryServiceDelegate
-(void)loginRes
{
    NSLog(@"loginRes");
        
    if ([[InquiryService sharedInstance] userVo]) {
        self.loginStatusLabel.stringValue = @"success";
        workWindowController = [[WorkWindowController alloc] init];
        [workWindowController showWindow];
    }
}


- (void)searchDone
{
    NSLog(@"searchDone");
    //通知する
    NSNotification *notification = [NSNotification notificationWithName:@"searchEnd" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)queryDone
{
    NSLog(@"queryDone");
    //通知する
    NSNotification *notification = [NSNotification notificationWithName:@"execQueryEnd" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (void)searchAllObjectsDone
{
    NSLog(@"getAllObjectsDone");
    //通知する
    NSNotification *notification = [NSNotification notificationWithName:@"searchAllObjectsEnd" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}
@end
