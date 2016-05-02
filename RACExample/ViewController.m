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

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /* [1] Create an Observable (called Signal in RAC) */

    // RACSignal *signal = ...

    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"Hello"];
        [subscriber sendNext:@"world"];

        [subscriber sendCompleted];

        return [RACDisposable disposableWithBlock:^{
            NSLog(@"Signal was disposed");
        }];
    }];

    [signal subscribeNext:^(id value) {
        NSLog(@"Got value: %@", value);
    }];

    /* [2] Get a signal sending the latest values of the text field */

    // RACSignal *textSignal = ...

    RACSignal *textSignal = self.textField.rac_textSignal;

    /* [4] Manipulate the text signal using basic operators */
    /* [5] Debug the signal by logging its values without subscribing */

    // RACSignal *uppercaseTextSignal = ...

    RACSignal *uppercaseTextSignal = [[textSignal map:^(NSString *text) {
        return text.uppercaseString; // transform values
    }]
    doNext:^(NSString *text) {
        NSLog(@"Got text: %@", text); // useful for debugging
    }];

    /* [6] Switch between value streams using a signal of signals */
    /* [7] Cache latest date value to avoid pause when switching to date signal */

    // Create a signal that sends the current date every second
    // RACSignal *dateSignal = ...

    RACSignal *dateSignal = [[RACSignal
        interval:1 onScheduler:[RACScheduler mainThreadScheduler]]
        replayLast]; // This implements [7]

    // Convert the dates to formatted date strings
    // RACSignal *dateStringSignal = ...

    RACSignal *dateStringSignal = [dateSignal map:^(NSDate *date) {
        return [NSDateFormatter localizedStringFromDate:date
            dateStyle:NSDateFormatterMediumStyle
            timeStyle:NSDateFormatterMediumStyle];
    }];

    // Get a signal that sends the segmented control's state
    // RACSignal *controlSignal = ...

    RACSignal *controlSignal = [[self.segmentedControl
        rac_newSelectedSegmentIndexChannelWithNilValue:@0]
        startWith:@0];

    // Get signal that switches between field text and date string values
    // RACSignal *labelTextSignal = ...

    RACSignal *labelTextSignal = [[controlSignal
        map:^(NSNumber *index) {
            NSUInteger indexValue = index.unsignedIntegerValue;
            switch (indexValue) {
                case 0:
                    return uppercaseTextSignal;
                case 1:
                    return dateStringSignal;
                default:
                    return [RACSignal empty];
            }
        }]
        switchToLatest];

    /* [3] Bind text of label to whatever the final signal sends */

    RAC(self.label, text) = labelTextSignal;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.textField becomeFirstResponder];
}

@end
