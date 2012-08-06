//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Tony Scarpino on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end


@implementation CalculatorViewController

@synthesize display;
@synthesize eval;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if(!_brain)
        _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

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
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.eval.text = [self.brain evalList];
}

- (IBAction)backspace {
    if (self.display.text.length == 1) {
        self.userIsInTheMiddleOfEnteringANumber = NO;
        self.display.text = @"";
    } else if (userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text substringToIndex:(self.display.text.length - 1)];
    }
}

- (IBAction)plusminus {
    if ([self.display.text characterAtIndex:0] == '-')
        self.display.text = [self.display.text substringFromIndex:1];
    else {
        self.display.text = [NSString stringWithFormat:@"-%@", self.display.text];
    }
}


- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    double result = [self.brain performOperation:[sender currentTitle]];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.eval.text = [self.brain evalList];
}

@end
