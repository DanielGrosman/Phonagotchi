//
//  Pet.m
//  Phonagotchi
//
//  Created by Daniel Grosman on 2017-11-09.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"

@implementation Pet

// sets the default state of the pet to not-grumpy, not-asleep, and has a restfulness of 10
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


// if the velocity of the 'pan' is higher than restfulness *100, the cat is Grumpy. As the restfulness goes down, the pet gets grumpy faster (e.g. in the beginning, the pet becomes grumpy at a velocity of 1000 (10 restfulness *100), when the pet's restfulness goes down to 5, for example, the cat will become grumpy at a velocity of 500
-(BOOL)petCat:(CGFloat) velocity {
    if (velocity > self.restfulness *100) {
        _isGrumpy = YES;
    } else {
        _isGrumpy = NO;
    }
    return _isGrumpy;
}

// creates a method to add to the pet's restfulness when it is sleeping, and decrease it's restfulness when it is not asleep. The method also tells the pet to sleep if it's restfulness reaches 0, and to wake up when it reaches 10
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
