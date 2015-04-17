//
//  WorkWindowController.m
//  Soap
//
//  Created by isid on 2015/04/02.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "WorkWindowController.h"


@implementation MyNSTableView
@synthesize  delegate;

- (void)copy:(id)sender{
    [self.delegate copyTableView];
}
@end

@implementation WorkWindowController

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)showWindow
{
    if (!_myWindow) {
        NSNib *nib = [[NSNib alloc] initWithNibNamed:@"WorkWindow" bundle:nil];
        BOOL result = [nib instantiateWithOwner:self topLevelObjects:nil];
        
        if (result) {
            NSLog(@"success");
        }else{
            NSLog(@"failed");
        }
    }
    [_myWindow makeKeyAndOrderFront:self];
    [self setData];

}

- (void)setData
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _resultTableView.delegate = self;
    _resultTableView.dataSource = self;
    
    _objectsTableView.delegate = self;
    _objectsTableView.dataSource = self;
    
    _sObjectNameText.stringValue = @"";
    
    NSFont *font = [NSFont fontWithName:@"Helvetica" size:14.0f];
    _textView.font = font;
    
    // 全オブジェクト取得
    [[InquiryService sharedInstance] searchAllObjects];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(searchAllObjectsEnd)
                               name:@"searchAllObjectsEnd"
                             object:nil];
}


- (IBAction)pushSObject:(id)sender {
    if ([[InquiryService sharedInstance] isLogined]) {
        [[InquiryService sharedInstance] searchSObject:_sObjectNameText.stringValue];
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(searchEnd)
                                   name:@"searchEnd"
                                 object:nil];

    }else{
        NSLog(@"failed");
    }
}

- (void)searchEnd
{
    NSLog(@"searchEnd");
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"searchEnd"
                                                  object:nil];

    if ([InquiryService sharedInstance].sObjects) {
        tmpSObjects = nil;
        tmpSObjects = [NSMutableArray array];
        for (SObject *obj in [InquiryService sharedInstance].sObjects) {
            if ([_checkCustom state] == NSOnState) {
                if ([obj.custom isEqualToString:@"true"]) {
                    [tmpSObjects addObject:obj];
                }
            }else{
                [tmpSObjects addObject:obj];
            }
        }
        [_tableView reloadData];
    }
    
}

- (IBAction)execQueryButton:(id)sender {
    [[InquiryService sharedInstance] execQuery:_textView.string];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(queryEnd)
                               name:@"execQueryEnd"
                             object:nil];

}
- (void)queryEnd
{
    NSLog(@"queryEnd");
    //table初期化
    [_resultTableView beginUpdates];
//    NSMutableIndexSet* rowindexes = [[NSMutableIndexSet alloc] init];
//    for (NSInteger i = 0; i < _resultTableView.numberOfRows; i++) {
//        // インデックスセットに値を設定します。
//        [rowindexes addIndex:i];
//    }
//    if (rowindexes.count > 0) {
//        [_resultTableView removeRowsAtIndexes:rowindexes withAnimation:NSTableViewAnimationEffectNone];
//    }

    while([[_resultTableView tableColumns] count] > 0) {
        [_resultTableView removeTableColumn:[[_resultTableView tableColumns] lastObject]];
    }
    if ([InquiryService sharedInstance].query) {
        NSArray *keys = [[InquiryService sharedInstance].query.result[0] allKeys];
        for (NSString *key in keys) {
            NSTableColumn *col = [[NSTableColumn alloc] initWithIdentifier:key];
            NSTableHeaderCell *headercell = [[NSTableHeaderCell alloc]initTextCell:key];
            [col setHeaderCell:headercell];
            [_resultTableView addTableColumn:col];
        }
    }

    [_resultTableView endUpdates];


    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"execQueryEnd"
                                                  object:nil];
    
    if ([InquiryService sharedInstance].query) {
        [_resultTableView reloadData];
    }
}
- (IBAction)deletebutton:(id)sender {
    while([[_resultTableView tableColumns] count] > 0) {
        [_resultTableView removeTableColumn:[[_resultTableView tableColumns] lastObject]];
    }
    
}
- (IBAction)checkCustomButton:(id)sender {
    tmpSObjects = nil;
    tmpSObjects = [NSMutableArray array];
    for (SObject *obj in [InquiryService sharedInstance].sObjects) {
        if ([_checkCustom state] == NSOnState) {
            if ([obj.custom isEqualToString:@"true"]) {
                [tmpSObjects addObject:obj];
            }
        }else{
            [tmpSObjects addObject:obj];
        }
    }
    [_tableView reloadData];
}

- (void)searchAllObjectsEnd
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"searchAllObjectsEnd"
                                                  object:nil];
    if ([InquiryService sharedInstance].objectList) {
        [_objectsTableView reloadData];
    }
}

#pragma --mark tableview delegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger cnt = 0;
    if (tableView == _tableView) {
        if (tmpSObjects) {
            cnt = tmpSObjects.count;
        }
    }else if (tableView == _resultTableView){
        if ([InquiryService sharedInstance].query) {
            cnt = [InquiryService sharedInstance].query.result.count;
        }
    }else if (tableView == _objectsTableView){
        if ([InquiryService sharedInstance].objectList) {
            cnt = [InquiryService sharedInstance].objectList.count;
        }
    }
    return cnt;
    
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *rtn = @"";

    if (tableView == _tableView) {
        SObject *tmp = tmpSObjects[row];
        if ([[tableColumn identifier] isEqualToString:@"label"]) {
            rtn = tmp.label;
        }else if ([[tableColumn identifier] isEqualToString:@"name"]){
            rtn = tmp.name;
        }else if ([[tableColumn identifier] isEqualToString:@"dataType"]){
            rtn = tmp.type;
        }else if ([[tableColumn identifier] isEqualToString:@"length"]){
            rtn = tmp.length;
        }else if ([[tableColumn identifier] isEqualToString:@"custom"]){
            rtn = tmp.custom;
        }
    }else if (tableView == _resultTableView){
        if ([InquiryService sharedInstance].query) {
            NSDictionary *dic = [InquiryService sharedInstance].query.result[row];
            NSArray *keys = [dic allKeys];
            for (NSString *key in keys) {
                if ([[tableColumn identifier] isEqualToString:key]) {
                    rtn = [dic objectForKey:key];
                }
            }
        }
    }else if (tableView == _objectsTableView){
        if ([InquiryService sharedInstance].objectList) {
            if ([[tableColumn identifier] isEqualToString:@"object"]) {
                SObject *obj = [InquiryService sharedInstance].objectList[row];
                rtn = obj.name;
            }
        }
    }
    return rtn;
}

-(void)tableViewSelectionIsChanging:(NSNotification *)aNotification
{
    NSTableView *table = aNotification.object;
    if (table == _objectsTableView && table.selectedRow >= 0 ) {
        SObject *obj = [InquiryService sharedInstance].objectList[table.selectedRow];
        _sObjectNameText.stringValue = obj.name;
        [[InquiryService sharedInstance] searchSObject:obj.name];
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(searchEnd)
                                   name:@"searchEnd"
                                 object:nil];
    }
}

#pragma --mark tableview delegate Ctr+C でコピー
- (void)copyTableView
{
    NSIndexSet* indexSet = [_tableView selectedRowIndexes];
	NSArray* columns = [_tableView tableColumns];
	
	NSUInteger selectedIndex;
	NSMutableString* string = [[NSMutableString alloc] init];
	NSPasteboard* pasteBoard = [NSPasteboard generalPasteboard];
	int i;
	BOOL result;
    
	if([indexSet indexGreaterThanOrEqualToIndex:0] == NSNotFound){
		//Column Copy
		indexSet = [_tableView selectedColumnIndexes];
		for(i = 0; i < [_tableView numberOfRows]; i++){
			selectedIndex=0;
            SObject *obj = [tmpSObjects objectAtIndex:i];
			while (true) {
				selectedIndex = [indexSet indexGreaterThanOrEqualToIndex:selectedIndex];
				if(selectedIndex == NSNotFound){
					break;
				}
                [string appendString:[obj valueForKey:[[columns objectAtIndex:selectedIndex] identifier]]];

				[string appendString:@"\t"];
				selectedIndex++;
			}
			[string appendString:@"\n"];
		}
	}else{
		//Row Copy
		selectedIndex=0;
		
		while (true) {
			selectedIndex=[indexSet indexGreaterThanOrEqualToIndex:selectedIndex];
			if(selectedIndex == NSNotFound){
				break;
			}
            SObject *obj = [tmpSObjects objectAtIndex:selectedIndex];
			for(i = 0; i < [columns count]; i++){
                if (class_getProperty([obj class], [[[columns objectAtIndex:i] identifier] UTF8String])) {
                    [string appendString:[obj valueForKey:[[columns objectAtIndex:i] identifier]]];
                }
                
				if(i != [tmpSObjects count] - 1){
					[string appendString:@"\t"];
				}
			}
			[string appendString:@"\n"];
			selectedIndex++;
		}
	}
	
	[pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:self];
	result=[pasteBoard setString:string forType:NSStringPboardType];
	if(result == NO){
		[[NSAlert alertWithMessageText:@"コピー失敗" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"テキストのコピーに失敗しました。"] runModal];
	}

}
@end
