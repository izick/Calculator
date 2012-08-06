//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Tony Scarpino on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong)NSMutableArray *programStack;
@property (nonatomic, strong)NSMutableArray *evalArray;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;
@synthesize evalArray;

- (NSMutableArray *)programStack
{
    if (!_programStack)
        _programStack = [[NSMutableArray alloc] init];

    return _programStack;
}

- (void)pushOperand:(double)operand {
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
    [self.evalArray addObject:[NSString stringWithFormat:@"%g",operand]];
}

+ (NSString *)descriptionOfPrgram:(id)program {
    return @"Implement this in Assignment 2";
}

+ (double)popOperandOffStack:(id)stack {
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack)
        [stack removeLastObject];
    if ([topOfStack isKindOfClass:[NSNumber class]])
        return [topOfStack doubleValue];
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrachend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrachend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor)
                result = [self popOperandOffStack:stack] / divisor;        
        } else if ([operation isEqualToString:@"SIN"]) {
            result = sin([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"COS"]) {
            result = cos([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"SQRT"]) {
            result = sqrt([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"π"]) {
            return (22/7.0);
        } else if ([operation isEqualToString:@"e"])
            return 2.71828;
    }
    return result;
}

+ (double)runProgram:(id)program {
    NSMutableArray *stack;
    
    if ([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    return [self popOperandOffStack:stack];
}

- (double)performOperation:(NSString *)operation {
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

- (id)program {
    return [self.programStack copy];
}

- (NSString *)evalList {
    if (evalArray.count > 6)
        [evalArray removeLastObject];
    
}

@end
