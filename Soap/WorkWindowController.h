//
//  WorkWindowController.h
//  Soap
//
//  Created by isid on 2015/04/02.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InquiryService.h"
#import "SObject.h"

@interface WorkWindowController : NSObject
<
InquiryServiceDelegate,
NSTableViewDataSource,
NSTableViewDelegate,
NSTextFieldDelegate
>
{
    NSMutableArray *tmpSObjects;
}
@property (strong) IBOutlet NSWindow *myWindow;
@property (weak) IBOutlet NSButton *sObjectButton;
@property (weak) IBOutlet NSTextField *sObjectNameText;
@property (weak) IBOutlet NSTableView *tableView;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (weak) IBOutlet NSButton *queryButton;
@property (weak) IBOutlet NSTableView *resultTableView;
@property (weak) IBOutlet NSTableView *objectsTableView;
@property (weak) IBOutlet NSButton *checkCustom;

- (void)showWindow;

@end
