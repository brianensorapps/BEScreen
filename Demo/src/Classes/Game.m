//
//  Game.m
//  AppScaffold
//
//  Created by Daniel Sperl on 14.01.10.
//  Copyright 2010 Incognitek. All rights reserved.
//

#import "Game.h" 

@implementation Game

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height])
    {
		mScreen = [BEScreen screenWithOrientation:BEScreenOrientationPortrait rotates:YES allowAllOrientations:YES];
		[self addChild:mScreen];

		quad = [[SPQuad alloc] initWithWidth:self.stage.width height:self.stage.height];
		quad.color = 0x0000ff;
		[mScreen addChild:quad];
		[quad release];
		text = [[SPTextField alloc] initWithWidth:self.stage.width height:self.stage.height text:@"Portrait" fontName:@"Helvetica Neue" fontSize:30 color:0xFFFFFF];
		[mScreen addChild:text];
		[text release];
		
		[mScreen addEventListener:@selector(orientationChanged:) atObject:self forType:BE_SCREEN_EVENT_ORIENTATIONCHANGED];
	}
    return self;
}

- (void)orientationChanged:(SPEvent *)event {
	switch ([mScreen orientation]) {
		case BEScreenOrientationPortrait:
			text.text = @"Portrait";
			text.width = self.stage.width;
			text.height = self.stage.height;
			quad.width = self.stage.width;
			quad.height = self.stage.height;
			break;
		case BEScreenOrientationPortraitUpsideDown:
			text.text = @"Portrait Upside Down";
			text.width = self.stage.width;
			text.height = self.stage.height;
			quad.width = self.stage.width;
			quad.height = self.stage.height;
			break;
		case BEScreenOrientationLandscapeRight:
			text.text = @"Landscape Right";
			text.width = self.stage.height;
			text.height = self.stage.width;
			quad.width = self.stage.height;
			quad.height = self.stage.width;
			break;
		case BEScreenOrientationLandscapeLeft:
			text.text = @"Landscape Left";
			text.width = self.stage.height;
			text.height = self.stage.width;
			quad.width = self.stage.height;
			quad.height = self.stage.width;
			break;
		default:
			break;
	}
}

@end
