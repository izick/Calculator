//
//  HappinessViewController.m
//  Happiness
//
//  Created by Tony Scarpino on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorDataSource.h"
#import "GraphViewController.h"
#import "GraphView.h"

@interface GraphViewController() <CalculatorDataSource>

@property (nonatomic, weak) IBOutlet GraphView *graphView;
@property (nonatomic, weak) IBOutlet id <CalculatorDataSource> dataSource;
@end

@implementation GraphViewController
@synthesize graphView = _graphView;
@synthesize dataSource = _dataSource;

- (void)setDataSource:(id<CalculatorDataSource>)dataSource
{
    _dataSource = dataSource;
    [self.graphView setNeedsDisplay];
}


- (void)setGraphView:(GraphView *)graphView
{
    _graphView = graphView;
    self.graphView.dataSource = self;
    [self.graphView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pinch:)]];
    [self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(smile:)]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(tap:)];
    tap.numberOfTapsRequired = 3;
    [self.graphView addGestureRecognizer:tap];
}

- (void) smile:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        
//        self.happiness += ([gesture translationInView:self.graphview].y / 2);
        CGPoint move = [gesture translationInView:self.graphView];
        self.graphView.zero = CGPointMake(move.x + self.graphView.zero.x,
                                          self.graphView.zero.y + move.y);
        [gesture setTranslation:CGPointZero inView:self.graphView];
    }
    [self.graphView setNeedsDisplay];
}



- (CGPoint)getPoints:(double)x
{
    return [self.dataSource getPoints:x];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
