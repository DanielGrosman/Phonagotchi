//
//  Pet.m
//  Phonagotchi
//
//  Created by Daniel Grosman on 2017-11-09.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"

@implementation Pet

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isGrumpy = NO;
        _isAsleep = NO;
        _restfulness = 10;
    }
    return self;
}


-(BOOL)petCat:(CGFloat) velocity {
    if (velocity > self.restfulness *100) {
        _isGrumpy = YES;
    } else {
        _isGrumpy = NO;
    }
    return _isGrumpy;
}

-(void)catSleeping {
    if (self.isAsleep){
        self.restfulness ++;
    } else {
        self.restfulness --;
    }
    
    if (self.restfulness == 0) {
        self.isAsleep = YES;
    } else if (self.restfulness == 10) {
        self.isAsleep = NO;
    }
    
}

@end
