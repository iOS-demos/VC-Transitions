//
//  IDSystemPresentationInnerTableView.m
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/22.
//

#import "IDSystemPresentationInnerTableView.h"

@interface IDSystemPresentationInnerTableView ()



@end

@implementation IDSystemPresentationInnerTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.y <= 0) {
        if (self.superview == otherGestureRecognizer.view) {
            return YES;
        }
    }
    return NO;
}

@end
