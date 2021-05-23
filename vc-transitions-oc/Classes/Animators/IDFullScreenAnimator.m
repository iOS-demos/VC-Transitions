//
//  IDFullScreenAnimator.m
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/22.
//

#import "IDFullScreenAnimator.h"

#define UIScreenWidth [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight [UIScreen mainScreen].bounds.size.height
#define duration 0.25

@implementation IDFullScreenForPresentedAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    UIView *toView = toVc.view;
    
    [containerView addSubview:toView];
    toView.frame = CGRectMake(0, UIScreenHeight, UIScreenWidth, UIScreenHeight);

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

@implementation IDFullScreenForDismissedAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *fromView = fromVc.view;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(0, UIScreenHeight, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
