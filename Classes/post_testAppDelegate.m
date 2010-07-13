//
//  post_testAppDelegate.m
//  post-test
//
//  Created by David Reynolds on 13/07/2010.
//  Copyright  2010. All rights reserved.
//

#import "post_testAppDelegate.h"

@implementation post_testAppDelegate

@synthesize window, pressMe, title, content;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

-(IBAction)buttonWasPressed {
	NSURL *postUrl = [NSURL URLWithString:@"http://localhost:8000/api/posts/"];
	NSArray *postKeys = [NSArray arrayWithObjects:@"title", @"content", nil];
	NSArray *postValues = [NSArray arrayWithObjects:title.text, content.text, nil];
	NSDictionary *postDict = [NSDictionary dictionaryWithObjects:postValues forKeys:postKeys];
	NSLog(@"%@", postDict);
	
	NSString *error;
	NSData *data = [NSPropertyListSerialization dataFromPropertyList:postDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	
	if (!data) {
		NSLog(@"%@", error);
		[error release];
	}
	else {
		NSString *postLength = [NSString stringWithFormat:@"%d",[data length]];
		NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
		[request setURL:postUrl];
		[request setHTTPMethod:@"POST"];
		[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
		[request setValue:@"application/plist" forHTTPHeaderField:@"Content-Type"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
		[request setHTTPBody:data];
		NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
		
		if (conn) {
			NSLog(@"Connection made");
		}
		else {
			NSLog(@"Connection error");
		}
	}
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
	NSLog(@"Data received %@", data);
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"%@", challenge);
	if ([challenge previousFailureCount] < 2) {
		NSLog(@"Sending credentials");
		NSURLCredential *credential = [NSURLCredential credentialWithUser:@"admin" password:@"sekrit" persistence:NSURLCredentialPersistenceNone];
		[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
	}
}

- (void)dealloc {
	[pressMe release];
    [window release];
    [super dealloc];
}


@end
