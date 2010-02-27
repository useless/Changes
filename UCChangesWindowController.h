//
//  UCChangesWindowController.h
//  Changes
//
//  Created by Christoph on 26.02.2010.
//  Copyright 2010 Useless Coding. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class UCChangesDocument;

@interface UCChangesWindowController : NSWindowController <NSToolbarDelegate, NSTableViewDataSource>
{
	IBOutlet NSView * historyView;
	IBOutlet NSView * diffView;
	IBOutlet NSView * contentImageView;
	IBOutlet NSView * contentTextView;

	IBOutlet NSTableView * versionsTable;
	IBOutlet NSTableColumn * versionsColumn;
	IBOutlet NSTableColumn * subjectColumn;
	IBOutlet NSTableColumn * dateColumn;

	IBOutlet NSImageView * contentPreview;
	IBOutlet NSTextView * contentText;
}

- (UCChangesDocument *)document;

- (void)setPreviewImage:(NSImage *)image;

- (void)showPane:(NSView *)pane;

- (IBAction)showHistory:(id)sender;
- (IBAction)showDiff:(id)sender;
- (IBAction)showContent:(id)sender;


@end
