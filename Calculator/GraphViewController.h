//
//  HappinessViewController.h
//  Happiness
//
//  Created by Tony Scarpino on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorDataSource.h"

@interface GraphViewController : UIViewController

- (void)setDataSource:(id<CalculatorDataSource>)data;
@end
