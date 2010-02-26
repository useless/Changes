//
//  MyDocument.m
//  Changes
//
//  Created by Christoph on 25.02.2010.
//  Copyright 2010 Useless Coding. All rights reserved.
//

#import "UCChangesDocument.h"
#import "UCChangesWindowController.h"


@implementation UCChangesDocument

- (id)init
{
    if(self = [super init])
		{
		}
	return self;
}

- (void) makeWindowControllers
{
	NSWindowController * mainController = [[UCChangesWindowController alloc] initWithWindowNibName:@"ChangesDocument" owner:self];
	[self addWindowController:mainController];
	[mainController release];
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
	[versionsTable setHighlightedTableColumn:versionsColumn];
	[super windowControllerDidLoadNib:aController];
}

- (BOOL)readFromURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
	BOOL isFolder = NO;
	if(![[NSFileManager defaultManager] fileExistsAtPath:[absoluteURL path] isDirectory:&isFolder] || isFolder)
		{
		if(outError!=NULL)
			{
			*outError = [NSError errorWithDomain:@"UCChangesErrors" code:UC_FOLDER_ERROR userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
				NSLocalizedString(@"Changes cannot be recorded for a folder.", @"Unable to open folder reason"), NSLocalizedFailureReasonErrorKey,
				NSLocalizedString(@"Try opening a file by choosing the Open command from the File menu.", @"Unable to open folder suggestion"), NSLocalizedRecoverySuggestionErrorKey,
				nil]];
			}
		return NO;
		}
    return YES;
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
	else if(tableColumn==versionsColumn)
		{
		return [NSString stringWithFormat:@"%@ 1.%d", row==5?@"•":@"", row];
		}
	return @"Lorem ipsum dolor";
}


@end
