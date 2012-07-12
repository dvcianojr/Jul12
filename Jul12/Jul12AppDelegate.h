//
//  Jul12AppDelegate.h
//  Jul12
//
//  Created by Dominick Ciano on 7/7/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>	//needed for MPMoviePlayerController
#import <AudioToolbox/AudioToolbox.h>
@class View;

@interface Jul12AppDelegate: UIResponder <UIApplicationDelegate> {
	MPMoviePlayerController *controller;
	View *view;
	UIWindow *_window;
	NSURL *url0;
	NSURL *url1;
	NSURL *url2;
	NSURL *url3;
	NSURL *url4;
	NSString *soundPath;
	SystemSoundID clickButtonSoundID;
}

- (void) valueChanged: (id) sender;

@property (strong, nonatomic) UIWindow *window;
@end

