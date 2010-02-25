//
//  UCChangesWindowController.h
//  Changes
//
//  Created by Christoph on 26.02.2010.
//  Copyright 2010 Useless Coding. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface UCChangesWindowController : NSWindowController <NSToolbarDelegate>
{

}

- (IBAction)showHistory:(id)sender;
- (IBAction)showDiff:(id)sender;
- (IBAction)showContent:(id)sender;


@end
