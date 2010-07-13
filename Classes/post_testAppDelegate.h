//
//  post_testAppDelegate.h
//  post-test
//
//  Created by David Reynolds on 13/07/2010.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface post_testAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UIButton *pressMe;
	UITextField *title;
	UITextView *content;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIButton	*pressMe;
@property (nonatomic, retain) IBOutlet UITextField *title;
@property (nonatomic, retain) IBOutlet UITextView *content;

-(IBAction)buttonWasPressed;

@end

