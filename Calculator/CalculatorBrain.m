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
@property (nonatomic, strong)NSDictionary *vars;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;
@synthesize vars;

- (NSMutableArray *)programStack
{
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
        vars = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithDouble:7], @"X",
        [NSNumber numberWithDouble:5], @"Y",
        [NSNumber numberWithDouble:3.3], @"Z", nil];

    }

    return _programStack;
}

- (void)pushOperand:(double)operand {
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

+ (NSString *)parser:(id)stack {
    
    id topOfStack = [stack lastObject];
    if (topOfStack)
        [stack removeLastObject];
    if ([topOfStack isKindOfClass:[NSNumber class]])
        return [NSString stringWithFormat:@"%@", topOfStack];
    NSString *operation = topOfStack;
    if ([operation isEqualToString:@"+"]) {
        NSString *v = [NSString stringWithFormat:@"%@", [self parser:stack]];
        return [NSString stringWithFormat:@"( %@ + %@ )",[self parser:stack], v];
    } else if ([operation isEqualToString:@"*"]) {
        NSString *v = [NSString stringWithFormat:@"%@", [self parser:stack]];
        return [NSString stringWithFormat:@"( %@ * %@ )",[self parser:stack], v];
    } else if ([operation isEqualToString:@"-"]) {
        NSString *v = [NSString stringWithFormat:@"%@", [self parser:stack]];
        return [NSString stringWithFormat:@"( %@ - %@ )",[self parser:stack], v];
    } else if ([operation isEqualToString:@"/"]) {
        NSString *v = [NSString stringWithFormat:@"%@", [self parser:stack]];
        return [NSString stringWithFormat:@"( %@ / %@ )",[self parser:stack], v];
    } else if ([operation isEqualToString:@"SIN"]) {
        return [NSString stringWithFormat:@"SIN( %@ )",[self parser:stack]];
    } else if ([operation isEqualToString:@"COS"]) {
        return [NSString stringWithFormat:@"COS( %@ )",[self parser:stack]];
    } else if ([operation isEqualToString:@"SQRT"]) {
        return [NSString stringWithFormat:@"SQRT( %@ )",[self parser:stack]];
    } else
        return [NSString stringWithFormat:@"%@", topOfStack];
    return @" ";
}

+ (NSString *)descriptionOfProgram:(id)program {
    NSString *str = @"";
    
    if ([program isKindOfClass:[NSArray class]])
        str = [self parser:[program mutableCopy]];

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

    }
    return result;
}

+ (NSSet *)variablesUsedInProgram:(id)program {
    NSMutableSet *set = [[NSMutableSet alloc] init];
    int i = 0;

    if ([program isKindOfClass:[NSArray class]]) {
        for (NSObject *obj in program) {
            if ([obj isKindOfClass:[NSString class]] && ([(NSString *)obj isEqualToString:@"X"] ||
                [(NSString *)obj isEqualToString:@"Y"] ||
                [(NSString *)obj isEqualToString:@"Z"]))
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

+ (double)runProgram:(id)program usingVariableValues: (NSDictionary *)variableValues {
    NSMutableArray *stack;
    NSSet *set;
    
    if ([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    if ((set = [self variablesUsedInProgram:stack]))
        for (NSNumber *i in set) {
            unsigned int ui = [i unsignedIntValue];
            NSNumber *value = [variableValues objectForKey:[stack objectAtIndex:ui]];
            if (value)
                [stack replaceObjectAtIndex:ui withObject:value];
            else
                [stack replaceObjectAtIndex:ui withObject:0];
        }
    return [self popOperandOffStack:stack];
    
}

- (double)performOperation:(NSString *)operation {
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

- (double)performOperation:(NSString *)operation: (NSDictionary *)variables {
    if (operation != nil)
        [self.programStack addObject:operation];
    return [[self class] runProgram:self.program usingVariableValues:variables];
}

- (id)program {
    return [self.programStack copy];
}



@end
