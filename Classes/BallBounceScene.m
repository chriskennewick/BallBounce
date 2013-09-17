//
//  BallBounceScene.m
//  BallBounce
//
//  Created by Christopher Kennewick
//

#import "BallBounceScene.h"


@implementation BallBounceScene

+(id) scene
{
	CCScene* scene = [CCScene node];
	CCLayer* layer = [BallBounceScene node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if((self = [super init]))
	{
		CCLOG(@"%@: %@", NSStringFromSelector(_cmd),self);
		self.isAccelerometerEnabled = YES;
		
		ball = [CCSprite spriteWithFile:@"baseball.png"];
		[self addChild:ball z:0 tag:1];
		
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		//float imageHeight = [ball texture].contentSize.height;
		ball.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
		
		ballVelocity.y = 5;
		
		CCRotateBy* rotateBy = [CCRotateBy actionWithDuration:2 angle:360];
		CCRepeatForever* repeat = [CCRepeatForever actionWithAction:rotateBy];
		[ball runAction:repeat];
		
		//CGSize size=[[CCDirector sharedDirector] winSize];
		xTilt = 0;
		yTilt = 0;
	    zTilt = 0;
		NSString* accelValues = [NSString stringWithFormat: @"x:%f y:%f z:%f", xTilt, yTilt, zTilt];
		accelAxisValues = [CCLabelTTF labelWithString:accelValues fontName:@"Marker Felt" fontSize:16];
		accelAxisValues.position = CGPointMake (screenSize.width/2, screenSize.height /2);
		accelAxisValues.tag = 10;
		[self addChild: accelAxisValues];
		
		//schedules the -(void) update:(ccTime)delta method to be called every frame
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	//controls how quickly velocity decelerates (lower = quicker to change direction)
	float deceleration = 0.4f;
	//determines how sensitive the accelerometer reacts (higher = more sensitive)
	float sensitivity = 6.0f;
	//how fast the velocity can be at most
	float maxVelocity = 100;
	
	//adjust velocity based on current accelerometer acceleration
	ballVelocity.x = ballVelocity.x * deceleration + acceleration.x * sensitivity;
	
	if(ballVelocity.x > maxVelocity)
	{
		ballVelocity.x = maxVelocity;	
	}
	else if (ballVelocity.x < - maxVelocity)
	{
		ballVelocity.x = - maxVelocity;
	}
	
	xTilt = acceleration.x;
	yTilt = acceleration.y;
	zTilt = acceleration.z;
	
	
}

-(void) update:(ccTime)delta
{
	[accelAxisValues setString:[NSString stringWithFormat: @"x:%.02f y:%.02f z:%.02f", xTilt, yTilt, zTilt]];
	
	//Keep adding up the playerVelocity to the player's position
	CGPoint pos = ball.position;
	pos.x += ballVelocity.x;
	
	pos.y += ballVelocity.y;
	
	//The Player should also be stopped from going outside the screen
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	float imageWidthHalved = [ball texture].contentSize.width * 0.5f;
	float leftBorderLimit = imageWidthHalved;
	float rightBorderLimit = screenSize.width - imageWidthHalved;
	
	float imageHeightHalved = [ball	texture].contentSize.height * 0.5f;
	float topBorderLimit = screenSize.height - imageHeightHalved;
	float bottomBorderLimit = imageHeightHalved;
	
	
	//Preventing the player sprite from moving outside the screen
	
	if(pos.x <leftBorderLimit)
	{
		pos.x = leftBorderLimit;
		ballVelocity.x=CGPointZero.x;
	}
	else if (pos.x > rightBorderLimit)
	{
		pos.x = rightBorderLimit;
		ballVelocity.x = CGPointZero.x;
	}
	
	if(pos.y > topBorderLimit)
	{
		ballVelocity.y = -5;
	}
	
	else if(pos.y < bottomBorderLimit)
	{
		ballVelocity.y = 5;
	}
	
	//assigning the modified position back
	ball.position = pos;
	
}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[super dealloc];
	
}
@end
