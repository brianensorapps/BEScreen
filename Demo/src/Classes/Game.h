//
//  Game.h
//  AppScaffold
//
//  Created by Daniel Sperl on 14.01.10.
//  Copyright 2010 Incognitek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEScreen.h"

@interface Game : SPStage {
	BEScreen *mScreen;
	SPQuad *quad;
	SPTextField *text;
}

@end
