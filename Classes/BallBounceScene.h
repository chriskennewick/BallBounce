//
//  BallBounceScene.h
//  BallBounce
//
//  Created by Christopher Kennewick
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BallBounceScene : CCLayer {
	CCSprite* ball;
	CGPoint ballVelocity;
	CCLabelTTF* accelAxisValues;
	UIAccelerationValue xTilt;
	UIAccelerationValue yTilt;
	UIAccelerationValue zTilt;
}

+(id) scene;
@end
