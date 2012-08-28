//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Tony Scarpino on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "GraphViewController.h"
#import "CalculatorDataSource.h"

@interface CalculatorViewController() <CalculatorDataSource>

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSMutableDictionary *variables;
//@property (weak, nonatomic) IBOutlet UIButton *graph;

@end


@implementation CalculatorViewController

@synthesize display;
@synthesize eval;
@synthesize variable_display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize variables;
//@synthesize graph;

- (CalculatorBrain *)brain
{
    if(!_brain) {
        _brain = [[CalculatorBrain alloc] init];
        variables = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     [NSNumber numberWithDouble:7], @"X",
                     [NSNumber numberWithDouble:5], @"Y",
                     [NSNumber numberWithDouble:3.3], @"Z",
                     nil];
    }
    return _brain;
}

- (IBAction)graphPressed:(id)sender {
    [self performSegueWithIdentifier:@"Graph" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Graph"]) {
        [segue.destinationViewController setDataSource:self];
    }
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
    self.eval.text = [self eval:[CalculatorBrain descriptionOfProgram:self.brain.program]];
//    self.eval.text = [self.brain evalList];
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
    double result = [self.brain performOperation:[sender currentTitle]: variables];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.eval.text = [self eval:[CalculatorBrain descriptionOfProgram:self.brain.program]];
    self.variable_display.text = [self variableDisplay];
}

- (NSString *)variableDisplay {
    NSEnumerator *keys = [variables keyEnumerator];
    id key;
    NSString *str = @"";

    while (key = [keys nextObject]) {
        str = [str stringByAppendingFormat:@"%@ = %@  ", key, [variables objectForKey:key]];
    }
    return str;
}

- (NSString *)eval:(NSString *)str {
    if (str.length > 40)
        return [str substringFromIndex:(str.length - 40)];
    return str;
}

- (void)viewDidUnload {
    [self setVariable_display:nil];
//    [self setGraph:nil];
    [super viewDidUnload];
}


- (CGPoint)getPoints:(double)x
{
    CGPoint point;
    point.x = x;
    [variables setObject:[NSNumber numberWithDouble:x] forKey:@"X"];
    point.y = [self.brain performOperation:self.display.text :variables];
    return point;
}

@end
