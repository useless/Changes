//
//  MyDocument.h
//  Changes
//
//  Created by Christoph on 25.02.2010.
//  Copyright 2010 Useless Coding. All rights reserved.
//


#import <Cocoa/Cocoa.h>


typedef enum {
	UC_FOLDER_ERROR
} UCChangesErrors;

@interface UCChangesDocument : NSDocument
{
	NSDictionary * qlDict;
	NSImage * previewImage;
	NSString * fileUTI;
	BOOL isText;
	NSString * currentVersion;
}

- (void)createPreview;
- (void)previewChanged;

- (void)generatePreviewForURL:(NSURL *)fileURL;
- (void)generateQuicklookForURL:(NSURL *)fileURL;

@property(readonly) BOOL isText;
@property(copy) NSString * currentVersion;

@end
