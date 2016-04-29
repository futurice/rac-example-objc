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

    /* Creating Observables (called signals in RAC) */

    // Get signal that sends latest text field values
    RACSignal *textSignal = self.textField.rac_textSignal;

    /*  Applying basic operators, debugging signals */

    RACSignal *uppercaseTextSignal = [[textSignal map:^(NSString *text) {
        return text.uppercaseString; // transform values
    }]
    doNext:^(NSString *text) {
        NSLog(@"Got text: %@", text); // useful for debugging
    }];

    /* Switching between value streams using a signal of signals */

    // Create signal that sends current date every second
    RACSignal *dateSignal = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] replayLast];

    RACSignal *dateTextSignal = [dateSignal map:^(NSDate *date) {
        return [NSDateFormatter localizedStringFromDate:date
            dateStyle:NSDateFormatterMediumStyle
            timeStyle:NSDateFormatterMediumStyle];
    }];

    // Get signal that sends state of segmented control
    RACSignal *controlSignal = [[self.segmentedControl
        rac_newSelectedSegmentIndexChannelWithNilValue:@0]
        startWith:@0];

    RACSignal *labelTextSignal = [[controlSignal
        map:^(NSNumber *index) {
            NSUInteger indexValue = index.unsignedIntegerValue;
            switch (indexValue) {
                case 0:
                    return uppercaseTextSignal;
                case 1:
                    return dateTextSignal;
                default:
                    return [RACSignal empty];
            }
        }]
        switchToLatest];

    /* Creating UI bindings */

    RAC(self.label, text) = labelTextSignal;
}

@end
