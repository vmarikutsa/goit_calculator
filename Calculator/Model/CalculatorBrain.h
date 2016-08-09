//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Kirill Kirikov on 8/8/16.
//  Copyright © 2016 Seductive Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CalcOperationNone,
    CalcOperationAdd,
    CalcOperationSub,
    CalcOperationMul,
    CalcOperationDiv,
    CalcOperationSqrt
} CalcOperation;

@interface NSString (CalcOperation)
- (CalcOperation) operation;
@end

@interface CalculatorBrain : NSObject
- (void) addDigit:(float)digit;
- (float) executeOperation:(CalcOperation)operation;
- (float) executeOperation:(CalcOperation)operation WithDigit:(float) digit;
- (void) refreshResults;
@end
