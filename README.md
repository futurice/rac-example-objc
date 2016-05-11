RAC Example
===========

## Intro

ReactiveCocoa (RAC) is a powerful framework for working with streams of values over time. It has already been added to the project workspace and is ready to use.

## Instructions

### 1. Create an Observable

Observables are called _signals_ in RAC. You can create one using `RACSignal`'s class method `createSignal`, which gives you a block from which you can send values and other events to subscribers. You need to return a `RACDisposable`, which allows you to clean up things once a subscription ends.

### 2. Get a signal that sends the text field's latest values

RAC comes with a range of categories on UIKit, which let you access properties such as `UITextField` values as streams. Every time the value changes, the stream sends a `Next` event carrying that value. These category methods all start with the `rac_` prefix.

### 3. Bind the text signal to the label

Once you have a signal that sends the text field's latest values, you can bind it to the label using the `RAC` macro:

```objective-c
RAC(self.label, text) = textSignal;
```

This also automatically terminates the subscription once the label gets deallocated.

### 4. Manipulate the text signal using basic operators

These operators include `map` for transforming values, and `filter` for skipping values based on a condition.

For instance, try converting the text field values to uppercase before displaying them in the label.

### 5. Debug the signal

RAC comes with useful logging features, such as the `doNext` operator. It lets us print the values to the console in a non-invasive fashion (without subscribing to the signal). Note that a subscription is still required at the end of the chain, or you won't see anything!

### 6. Switch between value streams using a signal of signals

The aim is to let the user control what they see in the label, using the segmented control. Depending on their choice, either the latest text field input or the current date is shown.

1. Create a signal that sends the current date every second.
1. Transform the dates into formatted date strings.
1. Get a signal that sends the segmented control's state.
1. Map the control values (`0` or `1` for the first and second segment, respectively) to the signals you want to switch between.
1. Use the `switchToLatest` operator to forward only values from latest returned "inner" signal.

### 7. Replay the latest value when switching to the date signal

The date signal sends a value every second, meaning that the label text won't update immediately when the user switches to it. We can fix this by appending `replayLast` to the date signal, which causes it to send its last value to new subscribers immediately upon subscription.

### 8. Fix long-running calculation

The `calculate` branch shows a tick counter in the text field and includes a Calculate button to simulate a long-running calculation. When the Calculate button is pressed, the tick counter freezes. Fix this so that the tick counter keeps updating at normal pace even when the simulated calculation is in progress.
