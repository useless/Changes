//
//  UCChangesWindowController.m
//  Changes
//
//  Created by Christoph on 26.02.2010.
//  Copyright 2010 Useless Coding. All rights reserved.
//

#import "UCChangesWindowController.h"


static NSString * sHistoryItem = @"UCHistory";
static NSString * sDiffItem = @"UCDiff";
static NSString * sContentItem = @"UCContent";
static NSString * sCommitItem = @"UCCommit";
static NSString * sRestoreItem = @"UCRestore";


@implementation UCChangesWindowController

- (void)windowDidLoad
{
	NSToolbar * toolbar = [[NSToolbar alloc] initWithIdentifier:@"UCChangesToolbar"];
	[toolbar setAllowsUserCustomization:YES];
	[toolbar setDelegate:self];
	[[self window] setToolbar:toolbar];
	[toolbar setSelectedItemIdentifier:sHistoryItem];
	[toolbar autorelease];
}

#pragma mark -

- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName
{
	return [NSString stringWithFormat:@"%@ (v%@)", displayName, @"1.3"];
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

#pragma mark Actions

- (IBAction)showHistory:(id)sender
{
	NSLog(@"Document: %@.", [self document]);
}

- (IBAction)showDiff:(id)sender
{
}

- (IBAction)showContent:(id)sender
{
}


@end
