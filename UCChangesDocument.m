//
//  MyDocument.m
//  Changes
//
//  Created by Christoph on 25.02.2010.
//  Copyright 2010 Useless Coding. All rights reserved.
//

#import "UCChangesDocument.h"
#import <QuickLook/QuickLook.h>
#import "UCChangesWindowController.h"


#define PREVIEW_SIZE 192.0


@implementation UCChangesDocument

- (id)init
{
    if(self = [super init])
		{
		qlDict = [[NSDictionary alloc] initWithObjectsAndKeys:(id)kCFBooleanTrue,
				  (id)kQLThumbnailOptionIconModeKey, nil];
		previewImage = nil;
		}
	return self;
}

- (void)dealloc
{
	NSLog(@"Bye Doc.");
	[previewImage release];
	[qlDict release];
	[fileUTI release];
	[currentVersion release];
	[super dealloc];
}

#pragma mark -

- (void) makeWindowControllers
{
	NSWindowController * mainController = [[UCChangesWindowController alloc] initWithWindowNibName:@"ChangesDocument"];
	[self addWindowController:mainController];
	[mainController release];
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
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

	currentVersion = @"1.3";

	isText = NO;

	NSWorkspace * ws = [NSWorkspace sharedWorkspace];
	fileUTI = [[ws typeOfFile:[absoluteURL path] error:NULL] retain];
	NSLog(@"Dateityp %@.", fileUTI);
	if(fileUTI!=nil && [ws type:fileUTI conformsToType:(NSString *)kUTTypeText])
		{
		isText = YES;
		NSLog(@"Datei ist Text.");
		}

    return YES;
}

- (void)createPreview
{
	if(previewImage==nil)
		{
		NSWorkspace * ws = [NSWorkspace sharedWorkspace];
		previewImage = [ws iconForFile:[[self fileURL] path]];
		[previewImage setSize:NSMakeSize(PREVIEW_SIZE, PREVIEW_SIZE)];
		[previewImage retain];
		[self previewChanged];

		if(fileUTI!=nil && [ws type:fileUTI conformsToType:(NSString *)kUTTypeImage])
			{
			[self performSelectorInBackground:@selector(generatePreviewForURL:) withObject:[[self fileURL] copy]];
			}
		else
			{
			[self performSelectorInBackground:@selector(generateQuicklookForURL:) withObject:[[self fileURL] copy]];
			}
		}
}

- (void)previewChanged
{
	[[self windowControllers] makeObjectsPerformSelector:@selector(setPreviewImage:) withObject:previewImage];
}

#pragma mark Preview Generation

- (void)generatePreviewForURL:(NSURL *)fileURL
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSImage * image = [[NSImage alloc] initWithContentsOfURL:fileURL];
	if(image!=nil && [[image representations] count])
		{
		NSImageRep * rep = [[image representations] objectAtIndex:0];
		[image setScalesWhenResized:YES];
		[image setSize:NSMakeSize([rep pixelsWide], [rep pixelsHigh])];
		[previewImage release];
		previewImage = [image retain];
		}
	[image release];
	[fileURL release];
	[self performSelectorOnMainThread:@selector(previewChanged) withObject:nil waitUntilDone:NO];
	[pool release];
}

- (void)generateQuicklookForURL:(NSURL *)fileURL
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"Generate QL.");
	CGImageRef quickLookIcon = QLThumbnailImageCreate(NULL, (CFURLRef)fileURL, CGSizeMake(PREVIEW_SIZE, PREVIEW_SIZE), (CFDictionaryRef)qlDict);
	if(quickLookIcon!=NULL)
		{
		[previewImage release];
		previewImage = [[NSImage alloc] init];
		[previewImage addRepresentation:[[NSBitmapImageRep alloc] initWithCGImage:quickLookIcon]];
		CFRelease(quickLookIcon);
		}
	[fileURL release];
	NSLog(@"QL Done.");
	[self performSelectorOnMainThread:@selector(previewChanged) withObject:nil waitUntilDone:NO];
	[pool release];
}

@synthesize isText, currentVersion;


@end
