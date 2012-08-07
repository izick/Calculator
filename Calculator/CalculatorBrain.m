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
@property (nonatomic, strong)NSMutableDictionary *variables;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;
@synthesize variables;

- (NSMutableArray *)programStack
{
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
        variables = [NSMutableDictionary dictionaryWithCapacity:3];
    }

    return _programStack;
}

- (void)pushOperand:(double)operand {
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

+ (NSString *)descriptionOfProgram:(id)program {
    NSString *str = @"";
    
    if ([program isKindOfClass:[NSArray class]])
        for (NSString *item in [program mutableCopy])
            str = [str stringByAppendingFormat:@"%@ ",item];
    return str;
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
        } else {
            [variables setObject:[self popOperandOffStack:stack] forKey:operation];
        }
    }
    return result;
}

+ (NSSet *)variablesUsedInProgram:(id)program {
    NSMutableSet *set = [[NSMutableSet alloc] init];
    int i;

    if ([program isKindOfClass:[NSArray class]]) {
        for (NSObject *obj in program) {
            if ([obj isKindOfClass:[NSString class]] && (obj == @"X" || obj == @"Y" || obj == @"Z"))
                [set addObject:[NSNumber numberWithUnsignedInteger:i]];
            i++;
        }
    }
    return set;
            
}

+ (double)runProgram:(id)program {
    NSMutableArray *stack;
    
    if ([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    return [self popOperandOffStack:stack];
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues {
    NSMutableArray *stack;
    NSSet *set;
    double result = 0;
    
    if ([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    if ((set = [self variablesUsedInProgram:stack]))
        for (NSNumber *i in set) {
            NSString *value = [variableValues objectForKey:[stack objectAtIndex:(NSUInteger)i]];
            if (value)
                [stack replaceObjectAtIndex:(NSUInteger)i withObject:value];
            else
                [stack replaceObjectAtIndex:(NSUInteger)i withObject:0];
        }
    [self popOperandOffStack:stack];
    return result;
    
}

- (double)performOperation:(NSString *)operation {
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

- (id)program {
    return [self.programStack copy];
}



@end
