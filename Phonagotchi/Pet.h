//
//  Pet.h
//  Phonagotchi
//
//  Created by Daniel Grosman on 2017-11-09.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject

@property (readonly) BOOL isGrumpy;

- (BOOL)petCat:(CGFloat)velocity;



@end
