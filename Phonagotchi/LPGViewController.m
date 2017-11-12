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

#pragma mark Load Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set the background color of the main view
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    // initialize an instance of Pet
    self.pet = [[Pet alloc] init];
    
    // create all the subviews
    [self createPetImageView];
    [self createBasketView];
    [self createAppleView];
    
    // set the constraints for all the subviews
    [self setPetImageViewConstraints];
    [self setBasketViewContraints];
    [self setAppleViewContraints];
    
    // create the gestureRecognizers
    [self createPanGestureRecognizer];
    [self createLongPressGestureRecognizer];
    [self createTapGestureRecognizer];
    
    // sets a timer on the isCatSleeping method, making it change it's sleeping state every 10 seconds
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(isCatSleeping) userInfo:nil repeats:YES];
}

#pragma mark Create Views
- (void) createPetImageView {
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.image = [UIImage imageNamed:@"default"];
    [self.view addSubview:self.petImageView];
}

- (void) createBasketView {
    self.basketView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.basketView.translatesAutoresizingMaskIntoConstraints = NO;
    self.basketView.image = [UIImage imageNamed:@"bucket"];
    [self.view addSubview:self.basketView];
}

- (void) createAppleView {
    self.appleView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleView.image = [UIImage imageNamed:@"apple"];
    [self.basketView addSubview:self.appleView];
}

- (void) createAppleTwoView {
    self.appleViewTwo= [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appleViewTwo.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleViewTwo.image = [UIImage imageNamed:@"apple"];
    [self.view addSubview:self.appleViewTwo];
}

#pragma mark Create View Constraints
- (void) setPetImageViewConstraints {
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
}

- (void) setBasketViewContraints {
    NSLayoutConstraint *basketHeight = [NSLayoutConstraint constraintWithItem:self.basketView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1
                                                                     constant:65];
    basketHeight.active = YES;
    NSLayoutConstraint *basketWidth = [NSLayoutConstraint constraintWithItem:self.basketView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1
                                                                    constant:65];
    basketWidth.active = YES;
    NSLayoutConstraint *basketbottom = [NSLayoutConstraint constraintWithItem:self.basketView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:-10];
    basketbottom.active = YES;
    NSLayoutConstraint *basketleading = [NSLayoutConstraint constraintWithItem:self.basketView
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1
                                                                      constant:10];
    basketleading.active = YES;
}

- (void) setAppleViewContraints {
    NSLayoutConstraint *appleHeight = [NSLayoutConstraint constraintWithItem:self.appleView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1
                                                                    constant:45];
    appleHeight.active = YES;
    NSLayoutConstraint *appleWidth = [NSLayoutConstraint constraintWithItem:self.appleView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:45];
    appleWidth.active = YES;
    NSLayoutConstraint *applebottom = [NSLayoutConstraint constraintWithItem:self.appleView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.basketView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:-18];
    applebottom.active = YES;
    NSLayoutConstraint *appleleading = [NSLayoutConstraint constraintWithItem:self.appleView
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.basketView
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1
                                                                     constant:10];
    appleleading.active = YES;
}
- (void) setAppleTwoViewConstraints {
    NSLayoutConstraint *appleTwoHeight = [NSLayoutConstraint constraintWithItem:self.appleViewTwo
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1
                                                                       constant:45];
    appleTwoHeight.active = YES;
    NSLayoutConstraint *appleTwoWidth = [NSLayoutConstraint constraintWithItem:self.appleViewTwo
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1
                                                                      constant:45];
    appleTwoWidth.active = YES;
    NSLayoutConstraint *appleTwobottom = [NSLayoutConstraint constraintWithItem:self.appleViewTwo
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.basketView
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1
                                                                       constant:-30];
    appleTwobottom.active = YES;
    NSLayoutConstraint *appleTwoleading = [NSLayoutConstraint constraintWithItem:self.appleViewTwo
                                                                       attribute:NSLayoutAttributeLeading
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.basketView
                                                                       attribute:NSLayoutAttributeLeading
                                                                      multiplier:1
                                                                        constant:20];
    appleTwoleading.active = YES;
}

#pragma mark Create Gesture Recognizers
- (void) createPanGestureRecognizer {
    UIPanGestureRecognizer *petGesture = [[UIPanGestureRecognizer alloc] init];
    [self.petImageView addGestureRecognizer:petGesture];
    self.petImageView.userInteractionEnabled = YES;
    [petGesture addTarget:self action:@selector(imageWasPanned:)];
}

- (void) createLongPressGestureRecognizer {
    self.lpGesture = [[UILongPressGestureRecognizer alloc] init];
    [self.appleView addGestureRecognizer:self.lpGesture];
    self.appleView.userInteractionEnabled = YES;
    self.basketView.userInteractionEnabled = YES;
    [self.lpGesture addTarget:self action:@selector(imageWasPressed:)];
}

- (void) createTapGestureRecognizer {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [self.petImageView addGestureRecognizer:tapGesture];
    self.petImageView.userInteractionEnabled = YES;
    [tapGesture setNumberOfTouchesRequired:2];
    [tapGesture addTarget:self action:@selector(petWasTapped:)];
}

#pragma mark Gesture Recognizer Implementation Methods
// creates the method for changing the pet's image to grumpy if the 'petting' it too fast
- (void)imageWasPanned:(UIPanGestureRecognizer *)sender {
    CGFloat velocity = [sender velocityInView:self.petImageView].x;
    BOOL grumpyCat = [self.pet petCat:velocity];
    if (grumpyCat == YES) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    }
}

// creates the method for making a sound when the pet is double tapped
-(void)petWasTapped: (UITapGestureRecognizer *) sender {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"meow"ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.player.numberOfLoops = 1;
    [self.player play];
}

// creates the method for dragging apples to the pet
-(void) imageWasPressed:(UILongPressGestureRecognizer *) sender {
    
    CGPoint location = [sender locationInView:self.view];
    
    if ([self.lpGesture state] == UIGestureRecognizerStateBegan){
        [self createAppleTwoView];
        [self setAppleTwoViewConstraints];
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

#pragma mark Cat Sleeping/Waking Up Methods
// calls the catSleeping method which changes the pet's restfulness based on whether it is awake or not. If the pet is sleeping, the image changes to sleeping, otherwise it changes back to the default image
-(void)isCatSleeping {
    [self.pet catSleeping];
    if (self.pet.isAsleep) {
        self.petImageView.image = [UIImage imageNamed:@"sleeping"];
    }
    else{
        self.petImageView.image = [UIImage imageNamed:@"default"];
    }
}

// if the phone is shaken, the isAsleep property is set to NO so the pet 'wakes up'
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.type == UIEventSubtypeMotionShake) {
        self.pet.isAsleep = NO;
    }
}

@end
