//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Tony Scarpino on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;

@end


@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;


- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (userIsInTheMiddleOfEnteringANumber)
        self.display.text = [self.display.text stringByAppendingString:digit];
    else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}


- (IBAction)enterPressed {
}


- (IBAction)operationPressed:(UIButton *)sender {
    NSString *operand = [sender currentTitle];
    
    if (operand == @"*") {
        
    }
}

@end
