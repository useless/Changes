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

@interface UCChangesDocument : NSDocument <NSTableViewDataSource>
{
	IBOutlet NSTableView * versionsTable;
	IBOutlet NSTableColumn * versionsColumn;
	IBOutlet NSTableColumn * subjectColumn;
	IBOutlet NSTableColumn * dateColumn;
}
@end
