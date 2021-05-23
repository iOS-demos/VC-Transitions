//
//  IDSystemPersentationInteractiveTransition.h
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDSystemPersentationInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)setPresentedViewController:(UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
