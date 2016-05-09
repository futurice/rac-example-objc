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

@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /* [1] Create an Observable (called Signal in RAC) */

    // RACSignal *signal = ...

    /* [2] Get a signal sending the latest values of the text field */

    // RACSignal *textSignal = ...

    /* [2b] And/or get a signal sending the current value of the slider */

    // RACSignal *sliderSignal = ...

    /* [4] Manipulate the text signal using basic operators */
    /* [5] Debug the signal by logging its values without subscribing */

    // RACSignal *uppercaseTextSignal = ...

    /* [6] Switch between value streams using a signal of signals */
    /* [7] Cache latest date value to avoid pause when switching to date signal */

    // Create a signal that sends the current date every second
    // RACSignal *dateSignal = ...

    // Convert the dates to formatted date strings
    // RACSignal *dateStringSignal = ...

    // Get a signal that sends the segmented control's state
    // RACSignal *controlSignal = ...

    // Get signal that switches between field text and date string values
    // RACSignal *labelTextSignal = ...

    /* [3] Bind text of label to whatever the final signal sends */
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.textField becomeFirstResponder];
}

@end
