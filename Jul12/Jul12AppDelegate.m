//
//  Jul12AppDelegate.m
//  Jul12
//
//  Created by Dominick Ciano on 7/7/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import "Jul12AppDelegate.h"
#import "View.h"
#import <QuartzCore/QuartzCore.h>
@implementation Jul12AppDelegate



@synthesize window = _window;

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
	// Override point for customization after application launch.
	NSBundle *bundle = [NSBundle mainBundle];
	if (bundle == nil) {
		NSLog(@"Could not access main bundle.");
		return YES;
	}
	// movie 0
	NSString *filename0 = [bundle pathForResource: @"Tornado" ofType: @"m4v"];
	if (filename0 == nil) {
		NSLog(@"could not find file Tornado.m4v");
		return YES;
	}
	
	url0 = [NSURL fileURLWithPath: filename0];
	if (url0 == nil) {
		NSLog(@"could not create URL for file %@", filename0);
		return YES;
	}
	// movie 1
	NSString *filename1 = [bundle pathForResource: @"ThunderAndLightning" ofType: @"m4v"];
	if (filename1 == nil) {
		NSLog(@"could not find file ThunderAndLightning.m4v");
		return YES;
	}
	
	url1 = [NSURL fileURLWithPath: filename1];
	if (url1 == nil) {
		NSLog(@"could not create URL for file %@", filename1);
		return YES;
	}
	
	// movie2
	
	NSString *filename2 = [bundle pathForResource: @"Volcanoe" ofType: @"m4v"];
	if (filename2 == nil) {
		NSLog(@"could not find file Volcanoe.m4v");
		return YES;
	}
	
	url2 = [NSURL fileURLWithPath: filename2];
	if (url2 == nil) {
		NSLog(@"could not create URL for file %@", filename2);
		return YES;		
	}
	
	
	// movie3
	
	NSString *filename3 = [bundle pathForResource: @"Earthquake" ofType: @"m4v"];
	if (filename3 == nil) {
		NSLog(@"could not find file Earthquake.m4v");
		return YES;
	}
	
	url3 = [NSURL fileURLWithPath: filename3];
	if (url3 == nil) {
		NSLog(@"could not create URL for file %@", filename3);
		return YES;
	}	
	
	controller = [[MPMoviePlayerController alloc] init];
	if (controller == nil) {
		NSLog(@"could not create MPMoviePlayerController");
		return YES;
	}
	
	// movie4
	
	NSString *filename4 = [bundle pathForResource: @"Tsunami" ofType: @"m4v"];
	if (filename4 == nil) {
		NSLog(@"could not find file Tsunami.mp4");
		return YES;
	}
	
	url4 = [NSURL fileURLWithPath: filename4];
	if (url4 == nil) {
		NSLog(@"could not create URL for file %@", filename4);
		return YES;
	}	
	
	controller = [[MPMoviePlayerController alloc] init];
	if (controller == nil) {
		NSLog(@"could not create MPMoviePlayerController");
		return YES;
	}
	
	
	
	controller.shouldAutoplay = NO; //don't start spontaneously
	controller.scalingMode = MPMovieScalingModeNone;
	controller.controlStyle = MPMovieControlStyleFullscreen;
	controller.movieSourceType = MPMovieSourceTypeFile; //vs. stream
	[controller setContentURL: url0];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	
	[center
	 addObserver: self
	 selector: @selector(playbackDidFinish:)
	 name: MPMoviePlayerPlaybackDidFinishNotification
	 object: controller
	 ];
	
	UIScreen *screen = [UIScreen mainScreen];
	view = [[View alloc] initWithFrame: screen.applicationFrame];
	self.window = [[UIWindow alloc] initWithFrame: screen.bounds];
	
	[self.window addSubview: view];
	[self.window makeKeyAndVisible];
	
	//load click.wav
	soundPath = [[NSBundle mainBundle] pathForResource:@"ButtonClick" ofType:@"wav"];			
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &clickButtonSoundID);

	
	// take screenshot - currently remmed out since it was only needed for building app's icon 
//		UIGraphicsBeginImageContext(self.window.bounds.size);
//		[self.window.layer renderInContext: UIGraphicsGetCurrentContext()];
//		UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//		UIGraphicsEndImageContext();
//		
//		if (image == nil) {
//			NSLog(@"UIGraphicsGetImageFromCurrentImageContext failed");
//			return YES;
//		}
//		
//		NSData *d = UIImagePNGRepresentation(image);
//		if (d == nil) {
//			NSLog(@"UIImagePNGRepresentation failed");
//			return YES;
//		}
//		
//		NSString *fileName = [NSString stringWithFormat:
//							  @"%@/jul12snapshot.png", NSHomeDirectory()];
//		
//		if (![d writeToFile: fileName atomically: NO]) {
//			NSLog(@"writeToFile:atomically: failed");
//			return YES;
//		}	
	
	return YES;
}

- (void) applicationWillResignActive: (UIApplication *) application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void) applicationDidEnterBackground: (UIApplication *) application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void) applicationWillEnterForeground: (UIApplication *) application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void) applicationDidBecomeActive: (UIApplication *) application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void) applicationWillTerminate: (UIApplication *) application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

- (void) valueChanged: (id) sender {
	UISwitch *s = sender;
	if (s.isOn) {
		//The UISwitch has just been turned on.
		view.enableButtons;
	} else {
		
		//The UISwitch has just been turned off.
		[controller stop];
		view.disableButtons;
	}
}


#pragma mark -
#pragma mark Application delegate is target of button.

- (void) touchUpInside0: (id) sender {
	//sender is the button.
	AudioServicesPlaySystemSound (clickButtonSoundID);	
	controller.view.frame = view.frame;
	[view removeFromSuperview];
	[controller setContentURL: url0];
	[self.window addSubview: controller.view];
	[controller play];
}

#pragma mark -
#pragma mark Application delegate is target of button.

- (void) touchUpInside1: (id) sender {
	//sender is the button.
	AudioServicesPlaySystemSound (clickButtonSoundID);	
	controller.view.frame = view.frame;
	[view removeFromSuperview];
	[controller setContentURL: url1];
	[self.window addSubview: controller.view];
	[controller play];
}
#pragma mark -
#pragma mark Application delegate is target of button.

- (void) touchUpInside2: (id) sender {
	//sender is the button.
	AudioServicesPlaySystemSound (clickButtonSoundID);	
	controller.view.frame = view.frame;
	[view removeFromSuperview];
	[controller setContentURL: url2];
	[self.window addSubview: controller.view];
	[controller play];
}
#pragma mark -
#pragma mark Application delegate is target of button.

- (void) touchUpInside3: (id) sender {
	//sender is the button.
	AudioServicesPlaySystemSound (clickButtonSoundID);
	controller.view.frame = view.frame;
	[view removeFromSuperview];
	[controller setContentURL: url3];
	[self.window addSubview: controller.view];
	[controller play];
}
#pragma mark -
#pragma mark Application delegate is target of button.

- (void) touchUpInside4: (id) sender {
	//sender is the button.
	AudioServicesPlaySystemSound (clickButtonSoundID);	
	controller.view.frame = view.frame;
	[view removeFromSuperview];
	[controller setContentURL: url4];
	[self.window addSubview: controller.view];
	[controller play];
}
#pragma mark -
#pragma mark Application delegate is observer of MPMoviePlayerController.

- (void) playbackDidFinish: (NSNotification *) notification {
	//notification.object is the movie player controller.
	[controller.view removeFromSuperview];
	[UIApplication sharedApplication].statusBarHidden = NO;
	[self.window addSubview: view];
}

@end