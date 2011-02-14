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

- (id)initWithOrientation:(int)orientation rotates:(BOOL)rotates allowAllOrientations:(BOOL)allowAllOrientations {
	if (self = [super init]) {
		mOrientation = orientation;
		mRotates = rotates;
		mAllowAllOrientations = allowAllOrientations;
		if (mOrientation == BEScreenOrientationPortrait) {
			self.rotation = SP_D2R(0);
			self.x = 0;
			self.y = 0;
			[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
		}
		if (mOrientation == BEScreenOrientationPortraitUpsideDown) {
			self.rotation = SP_D2R(180);
			self.x = self.stage.width;
			self.y = self.stage.height;
			[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortraitUpsideDown;
		}
		if (mOrientation == BEScreenOrientationLandscapeRight) {
			self.rotation = SP_D2R(90);
			self.x = self.stage.width;
			self.y = 0;
			[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
		}
		if (mOrientation == BEScreenOrientationLandscapeLeft) {
			self.rotation = SP_D2R(-90);
			self.x = 0;
			self.y = self.stage.height;
			[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
		}
		if (mRotates) {
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
			[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		}
	}
	return self;
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

- (void)dealloc {
    [super dealloc];
	if (mRotates) {
		[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
		[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	}
}

@end

