//
//  BEScreen.m
//
//  Created by Brian Ensor on 2/13/11.
//  Copyright 2011 Brian Ensor Apps. All rights reserved.
//

#import "BEScreen.h"

@implementation BEScreen
@synthesize orientation = mOrientation;
@synthesize rotates = mRotates;
@synthesize allowAllOrientations = mAllowAllOrientations;
@synthesize currentWidth = mCurrentWidth;
@synthesize currentHeight = mCurrentHeight;

- (id)initWithOrientation:(int)orientation rotates:(BOOL)rotates allowAllOrientations:(BOOL)allowAllOrientations {
	if (self = [super init]) {
		mOrientation = orientation;
		mRotates = rotates;
		mAllowAllOrientations = allowAllOrientations;
		switch (mOrientation) {
			case BEScreenOrientationPortrait:
				self.rotation = SP_D2R(0);
				self.x = 0;
				self.y = 0;
				[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
				break;
			case BEScreenOrientationPortraitUpsideDown:
				self.rotation = SP_D2R(180);
				self.x = self.stage.width;
				self.y = self.stage.height;
				[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortraitUpsideDown;
				break;
			case BEScreenOrientationLandscapeRight:
				self.rotation = SP_D2R(90);
				self.x = self.stage.width;
				self.y = 0;
				[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
				break;
			case BEScreenOrientationLandscapeLeft:
				self.rotation = SP_D2R(-90);
				self.x = 0;
				self.y = self.stage.height;
				[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
				break;
			default:
				break;
		}
		if (mRotates) {
			[self performSelector:@selector(beginListening) withObject:nil afterDelay:.5];
		}
	}
	return self;
}

- (void)beginListening {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (id)initWithOrientation:(int)orientation rotates:(BOOL)rotates {
	return [self initWithOrientation:orientation rotates:rotates allowAllOrientations:NO];
}

- (id)initWithOrientation:(int)orientation {
	return [self initWithOrientation:orientation rotates:NO allowAllOrientations:NO];
}

+ (BEScreen *)screenWithOrientation:(int)orientation rotates:(BOOL)rotates allowAllOrientations:(BOOL)allowAllOrientations {
	return [[[BEScreen alloc] initWithOrientation:orientation rotates:rotates allowAllOrientations:allowAllOrientations] autorelease];
}

+ (BEScreen *)screenWithOrientation:(int)orientation rotates:(BOOL)rotates {
	return [[[BEScreen alloc] initWithOrientation:orientation rotates:rotates] autorelease];
}

+ (BEScreen *)screenWithOrientation:(int)orientation {
	return [[[BEScreen alloc] initWithOrientation:orientation] autorelease];
}

- (void)onOrientationChange:(NSNotification *)notification {
	if (mRotates) {
		switch([UIDevice currentDevice].orientation)
		{
			case UIInterfaceOrientationPortrait:
				if (mAllowAllOrientations || mOrientation == BEScreenOrientationPortraitUpsideDown) {
					self.rotation = SP_D2R(0);
					self.x = 0;
					self.y = 0;
					[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
					mOrientation = BEScreenOrientationPortrait;
				}
				break;
			case UIInterfaceOrientationPortraitUpsideDown:
				if (mAllowAllOrientations || mOrientation == BEScreenOrientationPortrait) {
					self.rotation = SP_D2R(180);
					self.x = self.stage.width;
					self.y = self.stage.height;
					[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortraitUpsideDown;
					mOrientation = BEScreenOrientationPortraitUpsideDown;
				}
				break;
			case UIInterfaceOrientationLandscapeRight:
				if (mAllowAllOrientations || mOrientation == BEScreenOrientationLandscapeLeft) {
					self.rotation = SP_D2R(90);
					self.x = self.stage.width;
					self.y = 0;
					[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
					mOrientation = BEScreenOrientationLandscapeRight;
				}
				break;
			case UIInterfaceOrientationLandscapeLeft:
				if (mAllowAllOrientations || mOrientation == BEScreenOrientationLandscapeRight) {
					self.rotation = SP_D2R(-90);
					self.x = 0;
					self.y = self.stage.height;
					[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
					mOrientation = BEScreenOrientationLandscapeLeft;
				}
				break;
		}
		[self dispatchEvent:[SPEvent eventWithType:BE_SCREEN_EVENT_ORIENTATIONCHANGED]];
	}
}

- (float)currentWidth {
	switch (mOrientation) {
		case BEScreenOrientationPortrait:
		case BEScreenOrientationPortraitUpsideDown:
			return self.stage.width;
			break;
		case BEScreenOrientationLandscapeRight:
		case BEScreenOrientationLandscapeLeft:
			return self.stage.height;
			break;
		default:
			break;
	}
	return 0;
}

- (float)currentHeight {
	switch (mOrientation) {
		case BEScreenOrientationPortrait:
		case BEScreenOrientationPortraitUpsideDown:
			return self.stage.height;
			break;
		case BEScreenOrientationLandscapeRight:
		case BEScreenOrientationLandscapeLeft:
			return self.stage.width;
			break;
		default:
			break;
	}
	return 0;
}

- (void)setOrientation:(int)orientation {
	if (mOrientation != orientation) {
		switch (orientation) {
			case BEScreenOrientationPortrait:
				self.rotation = SP_D2R(0);
				self.x = 0;
				self.y = 0;
				[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
				break;
			case BEScreenOrientationPortraitUpsideDown:
				self.rotation = SP_D2R(180);
				self.x = self.stage.width;
				self.y = self.stage.height;
				[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortraitUpsideDown;
				break;
			case BEScreenOrientationLandscapeRight:
				self.rotation = SP_D2R(90);
				self.x = self.stage.width;
				self.y = 0;
				[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
				break;
			case BEScreenOrientationLandscapeLeft:
				self.rotation = SP_D2R(-90);
				self.x = 0;
				self.y = self.stage.height;
				[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
				break;
			default:
				[NSException raise:NSInvalidArgumentException format:@"Orientation value must be a valid BEScreenOrientation.", NSStringFromSelector(_cmd)];
				return;
		}
		mOrientation = orientation;
		[self dispatchEvent:[SPEvent eventWithType:BE_SCREEN_EVENT_ORIENTATIONCHANGED]];
	}
}

- (void)dealloc {
    [super dealloc];
	if (mRotates) {
		[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
		[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	}
}

@end

