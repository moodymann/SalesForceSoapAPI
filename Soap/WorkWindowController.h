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
#import "PickListValues.h"
#import "Utility.h"
@import ObjectiveC; //class_getProperty用

@protocol  MyNSTableViewDelegate
@optional
- (void)copyTableView;
@end

@interface MyNSTableView : NSTableView
- (void)copy:(id)sender;
@property (nonatomic, assign)id<MyNSTableViewDelegate>     delegate;

@end

@interface WorkWindowController : NSObject
<
InquiryServiceDelegate,
NSTableViewDataSource,
MyNSTableViewDelegate,
NSTableViewDelegate,
NSTextFieldDelegate
>
{
    NSMutableArray *tmpSObjects;
    NSMutableArray *filterObjects;
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
@property (weak) IBOutlet NSTextField *sortText;
@property (weak) IBOutlet NSButton *sortButton;


- (void)showWindow;

@end
