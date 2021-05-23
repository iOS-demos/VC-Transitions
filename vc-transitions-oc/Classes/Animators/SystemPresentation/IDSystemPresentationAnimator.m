//
//  IDSystemPresentationAnimator.m
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/22.
//

#import "IDSystemPresentationAnimator.h"
#import <QMUIKit/CALayer+QMUI.h>

#define UIScreenWidth [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight [UIScreen mainScreen].bounds.size.height
#define duration 0.25

static UIView *blackView = nil;

@implementation IDSystemPresentationForPresentedAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    [containerView addSubview:toView];

    if (!blackView) {
        blackView = [[UIView alloc] initWithFrame:[transitionContext initialFrameForViewController:fromVc]];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.tag = 100;
        [fromView.superview insertSubview:blackView belowSubview:fromView];
    }
    
    fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    fromView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMaxXMinYCorner;
    fromView.layer.masksToBounds = YES;

    CGFloat toViewFinalHeight = [UIScreen mainScreen].bounds.size.height * 0.94;
    toView.frame = CGRectMake(0, UIScreenHeight, UIScreenWidth, toViewFinalHeight);
    toView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMaxXMinYCorner;
    toView.layer.cornerRadius = 10;
    toView.layer.masksToBounds = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = CGAffineTransformMakeScale(0.95, 0.95);
        toView.frame = CGRectMake(0, UIScreenHeight - toViewFinalHeight, UIScreenWidth, toViewFinalHeight);
        
        fromView.layer.cornerRadius = 10;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end

@implementation IDSystemPresentationForDismissedAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
//    UIView *containerView = transitionContext.containerView;
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;

    CGRect fromViewInitialFrame = [transitionContext initialFrameForViewController:fromVc];
    BOOL hasBlackView = [toView.superview viewWithTag:100] != nil;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.transform = CGAffineTransformIdentity;
        if (hasBlackView) {
            toView.layer.cornerRadius = 0;
        }
        fromView.frame = CGRectOffset(fromViewInitialFrame, 0, fromViewInitialFrame.size.height);
    } completion:^(BOOL finished) {
        if (!transitionContext.transitionWasCancelled && hasBlackView) {
            [blackView removeFromSuperview];
            blackView = nil;
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
