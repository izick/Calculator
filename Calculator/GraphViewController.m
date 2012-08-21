//
//  HappinessViewController.m
//  Happiness
//
//  Created by Tony Scarpino on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"

@interface GraphViewController()

@property (nonatomic, weak) IBOutlet GraphView *graphview;
@end

@implementation GraphViewController
@synthesize graphview = _graphview;
@synthesize equation = _equation;

- (void)setEquation:(NSString *)equation
{
    _equation = equation;
    [self.graphview setNeedsDisplay];
}


- (void)setGraphView:(GraphView *)graphview
{
    _graphview = graphview;
//    self.graphview.dataSource = self;
    [self.graphview addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.graphview action:@selector(pinch:)]];
    [self.graphview addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(smile:)]];
}


- (void) smile:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        
//        self.happiness += ([gesture translationInView:self.graphview].y / 2);
        [gesture setTranslation:CGPointMake(0, 0) inView:self.graphview];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
