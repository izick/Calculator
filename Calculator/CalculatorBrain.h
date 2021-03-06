//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Tony Scarpino on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (double)performOperation:(NSString *)operation: (NSDictionary *)variableValues;
@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (double)runProgram:(id)program usingVariableValues: (NSDictionary *)variableValues;
+ (NSString *)descriptionOfProgram:(id)program;

@end
