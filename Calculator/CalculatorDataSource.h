//
//  CalculatorDataSource.h
//  Calculator
//
//  Created by Tony Scarpino on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalculatorDataSource <NSObject>
- (CGPoint)getPoints:(double)x;

@end
