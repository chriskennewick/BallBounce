//
//  BallBounceAppDelegate.h
//  BallBounce
//
//  Created by Christopher Kennewick
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface BallBounceAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
