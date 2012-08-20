//
//  HappinessViewController.m
//  Happiness
//
//  Created by Tony Scarpino on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"

@interface GraphViewController() <GraphViewDataSource>

@property (nonatomic, weak) IBOutlet GraphView *graphview;
@end

@implementation GraphViewController
@synthesize graphview = _graphview;
@synthesize happiness = _happiness;

- (void)setHappiness:(int)happiness
{
    if (happiness < 0)
        happiness = 0;
    else if (happiness > 100)
        happiness = 100;
    
    _happiness = happiness;
    [self.graphview setNeedsDisplay];
}


- (void)setGraphView:(GraphView *)graphview
{
    _graphview = graphview;
    self.graphview.dataSource = self;
    [self.graphview addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.graphview action:@selector(pinch:)]];
    [self.graphview addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(smile:)]];
}


- (float)smileForGraphView:(GraphView *)sender
{
    return (self.happiness - 50) / 50.0;
}


- (void) smile:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        
        self.happiness += ([gesture translationInView:self.graphview].y / 2);
        [gesture setTranslation:CGPointMake(0, 0) inView:self.graphview];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
