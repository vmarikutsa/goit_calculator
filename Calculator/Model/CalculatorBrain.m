//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Kirill Kirikov on 8/8/16.
//  Copyright © 2016 Seductive Mobile. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation NSString (CalcOperation)

- (CalcOperation) operation {
    if ([self isEqualToString:@"+"]) {
        return CalcOperationAdd;
    } else if ([self isEqualToString:@"-"]){
        return CalcOperationDiv;
    } else if ([self isEqualToString:@"×"]){
        return CalcOperationDiv;
    } else if ([self isEqualToString:@"÷"]){
        return CalcOperationDiv;
    } else if ([self isEqualToString:@"√"]){
        return CalcOperationSqrt;
    }
    return CalcOperationNone;
}

@end


@interface CalculatorBrain()
@property (strong) NSMutableArray<NSNumber *> *digits;
@property (assign) CalcOperation lastOperation;
@end

@implementation CalculatorBrain

#pragma mark - Constructor

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.digits = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Public Interface

- (void) addDigit:(float)digit {
    [self.digits addObject:@(digit)];
    //NSLog(@"Digits: %@", self.digits);
}

- (float) executeOperation:(CalcOperation)operation {
    switch (operation) {
        case CalcOperationAdd:
            return [self performOperationWithBlock:^float(float x, float y) {
                return x + y;
            }];
        case CalcOperationMul:
            return [self performOperationWithBlock:^float(float x, float y) {
                return x * y;
            }];
        case CalcOperationSub:
            return [self performOperationWithBlock:^float(float x, float y) {
                return y - x;
            }];
        case CalcOperationDiv:
            return [self performOperationWithBlock:^float(float x, float y) {
                return y / x;
            }];
        case CalcOperationSqrt:
            return [self performUnaryOperationWithBlock:^float(float x) {
                return sqrtf(x);
            }];
        default:
            return 0;
    }
}

- (float) executeOperation:(CalcOperation)operation WithDigit:(float) digit {
    float res;
    CalcOperation lastOperation = self.lastOperation;
    self.lastOperation = operation;
    [self addDigit:digit];
    if (lastOperation == CalcOperationNone) {
        res = digit;
    } else {
        res = [self executeOperation: lastOperation];
        [self addDigit:res];
    };
    return res;
}

- (float) performOperationWithBlock:(float (^)(float, float))operation {
    
    if (self.digits.count >= 2) {
        float x = [[self.digits lastObject] floatValue];
        [self.digits removeLastObject];
        
        float y = [[self.digits lastObject] floatValue];
        [self.digits removeLastObject];
        
        return operation(x, y);
    }
    
    return 0;
}

- (float) performUnaryOperationWithBlock:(float(^)(float))operation {
    
    if (self.digits.count >= 1) {
        float x = [[self.digits lastObject] floatValue];
        [self.digits removeLastObject];
        return operation(x);
    }
    
    return 0;
}

- (void) refreshResults {
    [self.digits removeAllObjects];
    self.lastOperation = CalcOperationNone;
}

#pragma mark -

@end
