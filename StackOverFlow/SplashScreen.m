//
//  SplashScreen.m
//  StackOverflow
//
//  Created by Aman Jain on 17/08/15.
//  Copyright (c) 2015 Aman. All rights reserved.
//

#import "SplashScreen.h"


@interface SplashScreen ()


@property (strong, nonatomic) NSTimer *timer;

@end

@implementation SplashScreen

double timerInterval = 1.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [UIView animateWithDuration:0.8
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // moves image up 30
                         self.image1.transform = CGAffineTransformMakeTranslation(0, -30);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.8
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn                                          animations:^{
                                              // move label up 20 to its original position
                                              self.label1.transform = CGAffineTransformMakeTranslation(0, -20);

                                          }
                                          completion:nil];
                     }];
}


- (NSTimer *) timer {
  
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:timerInterval target:self selector:@selector(onTick:) userInfo:nil repeats:NO];
    }
    
    //timer
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(delayFinished) userInfo:nil repeats:NO];
    
    return _timer;
}

-(void)onTick:(NSTimer*)timer
{
    _label1.text = @"Ask questions, get answers!!";
    _label1.font = [UIFont fontWithName:@"Helvetica Neue" size:20.0f]; //Custom Font
   
}

-(void)delayFinished{
    
    //open the segue
    [self performSegueWithIdentifier:@"show" sender:self];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
