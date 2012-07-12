//
//  View.m
//  Jul12
//
//  Created by Dominick Ciano on 7/11/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//
#import "View.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation View
@synthesize window = _window;

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor blueColor];
		
		// ***** create heading *****
		NSString *sHeading = NSLocalizedString(@"Heading", @"displayed with drawAtPoint:");
		//NSString *sHeading = @"Bad Weather Sensing Device";
		UIFont *hdgFont = [UIFont fontWithName: @"Arial-BoldMT" size: 16];
		CGSize hdgSize = [sHeading sizeWithFont: hdgFont];
		
        // set up heading
		CGRect f0 = CGRectMake(
							   self.bounds.origin.x + (self.bounds.size.width - hdgSize.width)/2,
							   self.bounds.origin.y,
							   hdgSize.width,
							   hdgSize.height + 10
							   );
		
		heading = [[UILabel alloc] initWithFrame: f0];
		heading.textColor = [UIColor whiteColor];
		heading.backgroundColor = [UIColor blueColor];
		heading.font = hdgFont;
		heading.text = sHeading;
		[self addSubview: heading];						
		
		// ***** power on/off switch *****
		//Do not specify a size for the switch.
		//Let the switch assume its own natural size.
		powerSwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
		if (powerSwitch == nil) {
			return nil;
		}
		
		//Call the valueChanged: method of the application delegate
		//when the value of the switch is changed.
		
		[powerSwitch addTarget: [UIApplication sharedApplication].delegate
						action: @selector(valueChanged:)
			  forControlEvents: UIControlEventValueChanged
		 ];
		
		//Center the switch in the SwitchView.
		CGRect b = self.bounds;
		
		powerSwitch.center = CGPointMake(
										 b.origin.x + b.size.width / 2,
										 50//b.origin.y + b.size.height / 2
										 );
		
		powerSwitch.on = NO;	//the default
		[self addSubview: powerSwitch];
		
		//***** add sensitivity slider *****
        // set up slider heading
		NSString *sSensHeading = NSLocalizedString(@"SensitivityHeading", @"displayed with drawAtPoint:");
		
		UIFont *sensHdgFont = [UIFont fontWithName: @"Arial-BoldMT" size: 14];
		CGSize sensHdgSize = [sHeading sizeWithFont: hdgFont];
		CGRect f1 = CGRectMake(
							   self.bounds.origin.x + 25,
							   97,
							   sensHdgSize.width,
							   sensHdgSize.height + 10
							   );
		
		sensitivityLabel = [[UILabel alloc] initWithFrame: f1];
		sensitivityLabel.textColor = [UIColor whiteColor];
		sensitivityLabel.backgroundColor = [UIColor blueColor];
		sensitivityLabel.font = sensHdgFont;
		sensitivityLabel.text = sSensHeading;
		[self addSubview: sensitivityLabel];							
		
		
		float minimumValue = 0;	
		float maximumValue = 100;
		
		//Center the slider in the View.
		CGSize s = CGSizeMake(maximumValue - minimumValue, 16);
		
		CGRect f2 = CGRectMake(
							   b.origin.x + (b.size.width - s.width) / 2,
							   100,//b.origin.y + (b.size.height - s.height) / 2,
							   s.width,
							   s.height
							   );
		
		slider = [[UISlider alloc] initWithFrame: f2];
		slider.minimumValue = minimumValue;
		slider.maximumValue = maximumValue;
		slider.value = (minimumValue + maximumValue) / 2;
		slider.continuous = YES;	//default is YES
		
		//As the slider goes from the minimum to the maximum value,
		//green goes from 0 to 1.  Conversely, blue goes from 1 to 0.
		
		CGFloat green = (slider.value - slider.minimumValue)
		/ (slider.maximumValue - slider.minimumValue);
		
		slider.backgroundColor = [UIColor colorWithRed:0.0
												 green: 0.0 blue: 1.0 - green alpha: 1.0];
		
		[slider addTarget:self
				   action: @selector(valueChanged:)
		 forControlEvents: UIControlEventValueChanged
		 ];
		
		[self addSubview: slider];
		//***** add buttons *****
		
		//1st button - Wind Storm Reporter 
		button0 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		
		//Center the button in the view.
		s = CGSizeMake(200, 40);	//size of button
		
		button0.frame = CGRectMake(
								   b.origin.x + (b.size.width - s.width) / 2,
								   b.origin.y + (b.size.height - s.height) / 2,
								   s.width,
								   s.height
								   );
		
		[button0 setTitleColor: [UIColor redColor]
					  forState: UIControlStateNormal];
		
		NSString *sButton0Caption = NSLocalizedString(@"Button0Caption", @"used to setTitle:");
		
		[button0 setTitle: sButton0Caption
				 forState: UIControlStateNormal];
		
		[button0 addTarget: [UIApplication sharedApplication].delegate
					action: @selector(touchUpInside0:)
		  forControlEvents: UIControlEventTouchUpInside];		
		
		
		
		
		//2nd button - Thunder Storm Reporter 
		button1 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		
		//Center the button in the view.
		s = CGSizeMake(200, 40);	//size of button
		
		button1.frame = CGRectMake(
								   b.origin.x + (b.size.width - s.width) / 2,
								   b.origin.y + (b.size.height - s.height) / 2 + 50,
								   s.width,
								   s.height
								   );
		
		[button1 setTitleColor: [UIColor redColor]
					  forState: UIControlStateNormal];
		
		NSString *sButton1Caption = NSLocalizedString(@"Button1Caption", @"used to setTitle:");
		
		[button1 setTitle: sButton1Caption
				 forState: UIControlStateNormal];
		
		[button1 addTarget: [UIApplication sharedApplication].delegate
					action: @selector(touchUpInside1:)
		  forControlEvents: UIControlEventTouchUpInside
		 ];
		
		//3rd button - Volcanoe Reporter
		
		button2 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		
		//Center the button in the view.
		CGSize s2 = CGSizeMake(200, 40);	//size of button
		CGRect b2 = self.bounds;
		
		button2.frame = CGRectMake(
								   b2.origin.x + (b2.size.width - s2.width) / 2,
								   b2.origin.y + (b2.size.height - s2.height) / 2 + 100,
								   s2.width,
								   s2.height
								   );
		
		[button2 setTitleColor: [UIColor redColor]
					  forState: UIControlStateNormal];
		
		
		NSString *sButton2Caption = NSLocalizedString(@"Button2Caption", @"used to setTitle:");
		
		[button2 setTitle: sButton2Caption
				 forState: UIControlStateNormal];		
		
		[button2 addTarget: [UIApplication sharedApplication].delegate
					action: @selector(touchUpInside2:)
		  forControlEvents: UIControlEventTouchUpInside
		 ];
		
		
		//4th button - Earthquake Reporter
		
		button3 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		
		//Center the button in the view.
		CGSize s3 = CGSizeMake(200, 40);	//size of button
		CGRect b3 = self.bounds;
		
		button3.frame = CGRectMake(
								   b3.origin.x + (b3.size.width - s3.width) / 2,
								   b3.origin.y + (b3.size.height - s3.height) / 2 + 150,
								   s3.width,
								   s3.height
								   );
		
		[button3 setTitleColor: [UIColor redColor]
					  forState: UIControlStateNormal];
		
		NSString *sButton3Caption = NSLocalizedString(@"Button3Caption", @"used to setTitle:");
		
		[button3 setTitle: sButton3Caption
				 forState: UIControlStateNormal];		
		
		[button3 addTarget: [UIApplication sharedApplication].delegate
					action: @selector(touchUpInside3:)
		  forControlEvents: UIControlEventTouchUpInside
		 ];
		
		
		//5th button - Tsunami Reporter
		
		button4 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		
		//Center the button in the view.
		CGSize s4 = CGSizeMake(200, 40);	//size of button
		CGRect b4 = self.bounds;
		
		button4.frame = CGRectMake(
								   b4.origin.x + (b4.size.width - s4.width) / 2,
								   b4.origin.y + (b4.size.height - s4.height) / 2 + 200,
								   s4.width,
								   s4.height
								   );
		
		[button4 setTitleColor: [UIColor redColor]
					  forState: UIControlStateNormal];
		
		NSString *sButton4Caption = NSLocalizedString(@"Button4Caption", @"used to setTitle:");
		
		[button4 setTitle: sButton4Caption
				 forState: UIControlStateNormal];		
		
		[button4 addTarget: [UIApplication sharedApplication].delegate
					action: @selector(touchUpInside4:)
		  forControlEvents: UIControlEventTouchUpInside
		 ];
		
		
		[self addSubview: button0];		
		[self addSubview: button1];
		[self addSubview: button2];
		[self addSubview: button3];
		[self addSubview: button4];
	}
	[self disableButtons];
	
	
	


	return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void) drawRect: (CGRect) rect
 {
 // Drawing code
 }
 */

- (void) valueChanged: (id) sender {
	UISlider *s = sender;
	
	float green = (s.value - s.minimumValue)
	/ (s.maximumValue - s.minimumValue);
	
	slider.backgroundColor = [UIColor colorWithRed:0
											 green: green blue: 1.0 - green alpha: 1.0];
	
	//	label.text = [NSString stringWithFormat: @"%5.1f° F == %5.1f° C",
	//				  slider.value, CELSIUS(slider.value)];
}
- (void) disableButtons{
	slider.value = 0;
	slider.enabled = NO;
	slider.backgroundColor = [UIColor colorWithRed: 0 green:0 blue:1.0 alpha:1.0];
	[button0 setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
	button0.enabled = NO;
	[button1 setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
	button1.enabled = NO;
	[button2 setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
	button2.enabled = NO;
	[button3 setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
	button3.enabled = NO;
	[button4 setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
	button4.enabled = NO;
}
- (void) enableButtons{
	slider.value = 100;
	slider.enabled = YES;
	slider.backgroundColor = [UIColor colorWithRed: 0 green:1.0 blue:0.0 alpha:1.0];
	slider.enabled = YES;
	[button0 setTitleColor: [UIColor redColor]forState:UIControlStateNormal];
	button0.enabled = YES;
	[button1 setTitleColor: [UIColor redColor]forState:UIControlStateNormal];
	button1.enabled = YES;
	[button2 setTitleColor: [UIColor redColor]forState:UIControlStateNormal];
	button2.enabled = YES;
	[button3 setTitleColor: [UIColor redColor]forState:UIControlStateNormal];
	button3.enabled = YES;
	[button4 setTitleColor: [UIColor redColor]forState:UIControlStateNormal];
	button4.enabled = YES;
}
@end
