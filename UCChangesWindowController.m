//
//  UCChangesWindowController.m
//  Changes
//
//  Created by Christoph on 26.02.2010.
//  Copyright 2010 Useless Coding. All rights reserved.
//

#import "UCChangesWindowController.h"
#import "UCChangesDocument.h"


static NSString * sHistoryItem = @"UCHistory";
static NSString * sDiffItem = @"UCDiff";
static NSString * sContentItem = @"UCContent";
static NSString * sCommitItem = @"UCCommit";
static NSString * sRestoreItem = @"UCRestore";


@implementation UCChangesWindowController

- (void)dealloc
{
	NSLog(@"Bye Window Controller.");
	[super dealloc];
}

- (UCChangesDocument *)document
{
	return [super document];
}

- (void)windowDidLoad
{
	NSToolbar * toolbar = [[NSToolbar alloc] initWithIdentifier:@"UCChangesToolbar"];
	[toolbar setAllowsUserCustomization:YES];
	[toolbar setDelegate:self];
	[[self window] setToolbar:toolbar];
	[toolbar setSelectedItemIdentifier:sHistoryItem];
	[toolbar release];

	[versionsTable setHighlightedTableColumn:versionsColumn];
	[self showPane:historyView];
}

- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName
{
	return [NSString stringWithFormat:@"%@ (v%@)", displayName, [self document].currentVersion];
}

#pragma mark -

- (void)setPreviewImage:(NSImage *)image
{
	[contentPreview setImage:image];
}

#pragma mark -

- (void)showPane:(NSView *)pane
{
	[historyView removeFromSuperview];
	[diffView removeFromSuperview];
	[contentImageView removeFromSuperview];
	[contentTextView removeFromSuperview];
	[pane setFrame:[[[self window] contentView] frame]];
	[[[self window] contentView] addSubview:pane];
}

#pragma mark Toolbar Delegate

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	NSToolbarItem * item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
	if([itemIdentifier isEqualToString:sHistoryItem])
		{
		[item setLabel:NSLocalizedString(@"History", @"History Toolbar Item Label")];
		[item setPaletteLabel:NSLocalizedString(@"Show History", @"History Toolbar Palette Label")];
		[item setAction:@selector(showHistory:)];
		[item setImage:[NSImage imageNamed:@"ToolbarHistory"]];
		}
	else if([itemIdentifier isEqualToString:sDiffItem])
		{
		[item setLabel:NSLocalizedString(@"Changes", @"Diff Toolbar Item Label")];
		[item setPaletteLabel:NSLocalizedString(@"Show Changes", @"Diff Toolbar Palette Label")];
		[item setAction:@selector(showDiff:)];
		[item setImage:[NSImage imageNamed:@"ToolbarDiff"]];
		}
	else if([itemIdentifier isEqualToString:sContentItem])
		{
		[item setLabel:NSLocalizedString(@"Content", @"Content Toolbar Item Label")];
		[item setPaletteLabel:NSLocalizedString(@"Show Content", @"Content Toolbar Palette Label")];
		[item setAction:@selector(showContent:)];
		[item setImage:[NSImage imageNamed:@"ToolbarContent"]];
		}
	else if([itemIdentifier isEqualToString:sRestoreItem])
		{
		[item setLabel:NSLocalizedString(@"Restore", @"Restore Toolbar Item Label")];
		[item setPaletteLabel:[item label]];
		[item setAction:@selector(restore:)];
		[item setImage:[NSImage imageNamed:@"ToolbarRestore"]];
		}
	else if([itemIdentifier isEqualToString:sCommitItem])
		{
		[item setLabel:NSLocalizedString(@"Commit", @"Commit Toolbar Item Label")];
		[item setPaletteLabel:[item label]];
		[item setAction:@selector(commit:)];
		[item setImage:[NSImage imageNamed:@"ToolbarCommit"]];
		[item setVisibilityPriority:NSToolbarItemVisibilityPriorityHigh];
		}
	else
		{
		[item release];
		return nil;
		}
	return [item autorelease];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar
{
	return [NSArray arrayWithObjects:sHistoryItem, sDiffItem, sContentItem,
			NSToolbarSeparatorItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier,
			sRestoreItem, NSToolbarSpaceItemIdentifier, sCommitItem, nil];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar
{
	return [NSArray arrayWithObjects:sCommitItem, sRestoreItem, sHistoryItem, sDiffItem,
			sContentItem, NSToolbarSeparatorItemIdentifier, NSToolbarSpaceItemIdentifier,
			NSToolbarFlexibleSpaceItemIdentifier, NSToolbarCustomizeToolbarItemIdentifier,
			nil];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar
{
	return [NSArray arrayWithObjects:sHistoryItem, sDiffItem, sContentItem, nil];
}

#pragma mark History Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return 42;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	if(tableColumn==dateColumn)
		{
		return [NSDate date];
		}
	else if([[tableColumn identifier] isEqualToString:[versionsColumn identifier]])
		{
		return [NSString stringWithFormat:@"%@ 1.%d", row==5?@"•":@"", row+1];
		}
	return @"Lorem ipsum dolor";
}

#pragma mark Actions

- (IBAction)showHistory:(id)sender
{
	[self showPane:historyView];
}

- (IBAction)showDiff:(id)sender
{
	[self showPane:diffView];
}

- (IBAction)showContent:(id)sender
{
	if([self document].isText)
		{
		[self showPane:contentTextView];
		}
	else
		{
		[[self document] createPreview];
		[self showPane:contentImageView];
		}
}


@end
