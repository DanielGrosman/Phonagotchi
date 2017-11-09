//
//  Pet.m
//  Phonagotchi
//
//  Created by Daniel Grosman on 2017-11-09.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"

@implementation Pet


-(BOOL)petCat:(CGFloat) velocity {
    CGFloat grumpySpeed = 800;
    if (velocity > grumpySpeed) {
        _isGrumpy = YES;
    } else {
        _isGrumpy = NO;
    }
    return _isGrumpy;
}

@end
