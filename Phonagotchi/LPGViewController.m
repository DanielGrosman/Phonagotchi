//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "Pet.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *appleView;
@property (nonatomic) UIImageView *appleViewTwo;
@property (nonatomic) UIImageView *basketView;
@property Pet *pet;


@property UILongPressGestureRecognizer *lpGesture;

@property AVAudioPlayer *player;

@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    self.pet = [[Pet alloc] init];
    
    // Create the penGestureRecognizer and add it to the petImageView
    UIPanGestureRecognizer *petGesture = [[UIPanGestureRecognizer alloc] init];
    [self.petImageView addGestureRecognizer:petGesture];
    self.petImageView.userInteractionEnabled = YES;
    [petGesture addTarget:self action:@selector(imageWasPanned:)];
    
    //initialize the basketView
    self.basketView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.basketView.translatesAutoresizingMaskIntoConstraints = NO;
    self.basketView.image = [UIImage imageNamed:@"bucket"];
    [self.view addSubview:self.basketView];
    
    NSLayoutConstraint *basketHeight = [NSLayoutConstraint constraintWithItem:self.basketView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:65];
    basketHeight.active = YES;
    NSLayoutConstraint *basketWidth = [NSLayoutConstraint constraintWithItem:self.basketView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:65];
    basketWidth.active = YES;
    NSLayoutConstraint *basketbottom = [NSLayoutConstraint constraintWithItem:self.basketView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    basketbottom.active = YES;
    NSLayoutConstraint *basketleading = [NSLayoutConstraint constraintWithItem:self.basketView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
    basketleading.active = YES;
    
    
    //initialize the AppleView
    self.appleView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleView.image = [UIImage imageNamed:@"apple"];
    [self.basketView addSubview:self.appleView];
    
    NSLayoutConstraint *appleHeight = [NSLayoutConstraint constraintWithItem:self.appleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:45];
    appleHeight.active = YES;
    NSLayoutConstraint *appleWidth = [NSLayoutConstraint constraintWithItem:self.appleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:45];
    appleWidth.active = YES;
    NSLayoutConstraint *applebottom = [NSLayoutConstraint constraintWithItem:self.appleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.basketView attribute:NSLayoutAttributeBottom multiplier:1 constant:-18];
    applebottom.active = YES;
    NSLayoutConstraint *appleleading = [NSLayoutConstraint constraintWithItem:self.appleView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.basketView attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
    appleleading.active = YES;
    
    //create a pinchGestureView
    self.lpGesture = [[UILongPressGestureRecognizer alloc] init];
    [self.appleView addGestureRecognizer:self.lpGesture];
    self.appleView.userInteractionEnabled = YES;
    self.basketView.userInteractionEnabled = YES;
    [self.lpGesture addTarget:self action:@selector(imageWasPressed:)];
    
    //create a tapGesture to make the pet make a sound when you doubletap on it
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [self.petImageView addGestureRecognizer:tapGesture];
    self.petImageView.userInteractionEnabled = YES;
    [tapGesture setNumberOfTouchesRequired:2];
    [tapGesture addTarget:self action:@selector(petWasTapped:)];
    
}
//Create the method for making a sound when the pet is double tapped
-(void)petWasTapped: (UITapGestureRecognizer *) sender {
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"meow"ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.player.numberOfLoops = 1;
    [self.player play];
}

// Create the method for changing the image if the petting is too fast
- (void)imageWasPanned:(UIPanGestureRecognizer *)sender {
    CGFloat velocity = [sender velocityInView:self.petImageView].x;
    BOOL grumpyCat = [self.pet petCat:velocity];
    if (grumpyCat == YES) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    }
    }
// Create the method for dragging apples to the pet
-(void) imageWasPressed:(UILongPressGestureRecognizer *) sender {
    
    CGPoint location = [sender locationInView:self.view];
    
    if ([self.lpGesture state] == UIGestureRecognizerStateBegan){
    self.appleViewTwo= [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appleViewTwo.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleViewTwo.image = [UIImage imageNamed:@"apple"];
    [self.view addSubview:self.appleViewTwo];
    
    NSLayoutConstraint *appleTwoHeight = [NSLayoutConstraint constraintWithItem:self.appleViewTwo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:45];
    appleTwoHeight.active = YES;
    NSLayoutConstraint *appleTwoWidth = [NSLayoutConstraint constraintWithItem:self.appleViewTwo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:45];
    appleTwoWidth.active = YES;
    NSLayoutConstraint *appleTwobottom = [NSLayoutConstraint constraintWithItem:self.appleViewTwo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.basketView attribute:NSLayoutAttributeBottom multiplier:1 constant:-30];
    appleTwobottom.active = YES;
    NSLayoutConstraint *appleTwoleading = [NSLayoutConstraint constraintWithItem:self.appleViewTwo attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.basketView attribute:NSLayoutAttributeLeading multiplier:1 constant:20];
    appleTwoleading.active = YES;
    }
    
    if ([self.lpGesture state] == UIGestureRecognizerStateChanged) {
        self.appleViewTwo.center = location;
    }
    
    if ([self.lpGesture state] == UIGestureRecognizerStateEnded) {
        
            if (CGRectIntersectsRect(self.appleViewTwo.frame, self.petImageView.frame)) {
                [UIView animateWithDuration:1.0 animations:^{
                    self.appleViewTwo.alpha = 0.0;
                } completion:^(BOOL finished) {
                }];
                
            } else {
                [UIView animateWithDuration:1.0 animations:^{
                    self.appleViewTwo.frame = CGRectMake(self.appleViewTwo.frame.origin.x, (self.view.bounds.size.height + 100), self.appleViewTwo.frame.size.width, self.appleViewTwo.frame.size.height);
                } completion:^(BOOL finished) {
                    self.appleViewTwo.alpha = 0.0;
                }];
    }
    }
}


@end
