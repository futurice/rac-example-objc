//
//  ViewController.m
//  RACExample
//
//  Created by Martin Richter on 29/04/16.
//  Copyright © 2016 Futurice. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Creating Observables (called Signals in RAC)
    RACSignal *textSignal = self.textField.rac_textSignal;

    // Applying basic operators
    RACSignal *uppercaseTextSignal = [[textSignal map:^(NSString *text) {
        return text.uppercaseString;
    }]
    // Debugging signals
    doNext:^(NSString *text) {
        NSLog(@"Got text: %@", text);
    }];

    // Creating UI bindings
    RAC(self.label, text) = uppercaseTextSignal;
}

@end
