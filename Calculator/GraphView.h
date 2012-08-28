//
//  GraphView.h
//  Happiness
//
//  Created by Tony Scarpino on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorDataSource.h"

//@protocol GraphViewDataSource;

/*
@protocol GraphViewDataSource
- (CGPoint)getPoints:(GraphView *)sender x:(double)x;
@end
*/
@interface GraphView : UIView

@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat smile;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic, weak) IBOutlet id <CalculatorDataSource> dataSource;
@end
