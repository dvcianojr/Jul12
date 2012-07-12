//
//  View.h
//  Jul12
//
//  Created by Dominick Ciano on 7/11/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@interface View: UIView {
	UILabel *heading;
	UILabel *sensitivityLabel;
	UISwitch *powerSwitch;
	UISlider *slider;
	UIButton *button0;
	UIButton *button1;
	UIButton *button2;
	UIButton *button3;
	UIButton *button4;
	NSString *soundPath;

	
}
- (void) enableButtons;
- (void) disableButtons;
@property (strong, nonatomic) UIWindow *window;

@end
