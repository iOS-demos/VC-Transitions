//
//  IDJDProductDetailAnimator.m
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/23.
//

#import "IDJDProductDetailAnimator.h"
#import <QMUIKit/CALayer+QMUI.h>

#define UIScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDuration 0.3
#define kAngle M_PI / 180.0f * 15.0f

@interface IDJDProductDetailForPresentedAnimator ()

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation IDJDProductDetailForPresentedAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC)];
    [containerView addGestureRecognizer:tapGest];
    self.transitionContext = transitionContext;
    
    UIView *blackView = [[UIView alloc] initWithFrame:[transitionContext initialFrameForViewController:fromVc]];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.tag = 100;
    [fromView.superview insertSubview:blackView belowSubview:fromView];

    [containerView addSubview:toView];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVc];
    CGFloat toViewHeight = 300;
    toView.frame = CGRectMake(0, UIScreenHeight - toViewHeight, toViewFinalFrame.size.width, toViewHeight);
    toView.frame = CGRectOffset(toView.frame, 0, toViewHeight);
    toView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMaxXMinYCorner;
    toView.layer.cornerRadius = 10;
    toView.layer.masksToBounds = YES;


    fromView.layer.zPosition = 500;
    fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    __block CATransform3D fromViewTransform = CATransform3DIdentity;
    fromViewTransform.m34 = -0.002;
    fromViewTransform = CATransform3DRotate(fromViewTransform, kAngle, 1, 0, 0);
    
    __block BOOL animation1Finished = NO;
    __block BOOL animation2Finished = NO;
    
    void (^finishBlock)(BOOL, BOOL) = ^(BOOL finished1, BOOL finished2) {
        if (finished1 && finished2) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }
    };
    
    [UIView animateWithDuration:kDuration animations:^{
        fromView.layer.transform = fromViewTransform;
    } completion:^(BOOL finished) {
        fromViewTransform = CATransform3DIdentity;
        fromViewTransform.m34 = -0.002;
        fromViewTransform = CATransform3DTranslate(fromViewTransform, 0, 0, -20);
        [UIView animateWithDuration:kDuration animations:^{
            fromView.layer.transform = fromViewTransform;
        } completion:^(BOOL finished) {
            animation1Finished = YES;
            finishBlock(animation1Finished, animation2Finished);
        }];
    }];
    
    [UIView animateWithDuration:kDuration * 2 animations:^{
        toView.frame = CGRectOffset(toView.frame, 0, -toViewHeight);
    } completion:^(BOOL finished) {
        animation2Finished = YES;
        finishBlock(animation1Finished, animation2Finished);
    }];
}

- (void)dismissVC {
    if (self.transitionContext) {
        UIViewController *fromVc = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [fromVc dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

@implementation IDJDProductDetailForDismissedAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
//    UIView *containerView = transitionContext.containerView;
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    __block UIView *blackView = [toView.superview viewWithTag:100];
    
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:toVc];
    
    toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    __block CATransform3D toViewTransform = CATransform3DIdentity;
    toViewTransform.m34 = -0.002;
    toViewTransform = CATransform3DRotate(toViewTransform, kAngle, 1, 0, 0);
    
    __block BOOL animation1Finished = NO;
    __block BOOL animation2Finished = NO;
    
    void (^finishBlock)(BOOL, BOOL) = ^(BOOL finished1, BOOL finished2) {
        if (finished1 && finished2) {
            if (blackView) {
                [blackView removeFromSuperview];
                blackView = nil;
            }
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }
    };
    
    [UIView animateWithDuration:kDuration animations:^{
        toView.layer.transform = toViewTransform;
    } completion:^(BOOL finished) {
        toViewTransform = CATransform3DIdentity;
        toViewTransform.m34 = -0.002;
//        toViewTransform = CATransform3DTranslate(toViewTransform, 0, 0, 20);
//        toViewTransform = CATransform3DRotate(toViewTransform, -10.0f * M_PI/180.0f, 1, 0, 0);
        [UIView animateWithDuration:kDuration animations:^{
            toView.layer.transform = toViewTransform;
        } completion:^(BOOL finished) {
            animation1Finished = YES;
            finishBlock(animation1Finished, animation2Finished);
        }];
    }];
    
    [UIView animateWithDuration:kDuration * 2 animations:^{
        fromView.frame = CGRectOffset(fromView.frame, 0, fromViewFinalFrame.size.height);
    } completion:^(BOOL finished) {
        animation2Finished = YES;
        finishBlock(animation1Finished, animation2Finished);
    }];
}

@end
