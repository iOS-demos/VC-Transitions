//
//  IDJDProductDetailViewController.m
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/23.
//

#import "IDJDProductDetailViewController.h"
#import "IDJDProductDetailMoreViewController.h"
#import "IDJDProductDetailAnimator.h"

@interface IDJDProductDetailViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) IDJDProductDetailForPresentedAnimator *presentedAnimator;
@property (nonatomic, strong) IDJDProductDetailForDismissedAnimator *dismissedAnimator;

@end

@implementation IDJDProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [self.view addSubview:bgImageView];
    bgImageView.frame = self.view.bounds;
    
    bgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMoreInfo)];
    [bgImageView addGestureRecognizer:tapGest];
    
    bgImageView.image = [self imageWithName:@"jd-product-detail-vc"];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:dismissBtn];
    
    dismissBtn.frame = CGRectMake(10, 44, 100, 50);
    dismissBtn.backgroundColor = [UIColor systemPinkColor];

    [dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Event
- (void)showMoreInfo {
    IDJDProductDetailMoreViewController *dtMoreVc = [[IDJDProductDetailMoreViewController alloc] init];
    dtMoreVc.transitioningDelegate = self;
    dtMoreVc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:dtMoreVc animated:YES completion:nil];
}

- (void)dismissBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentedAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissedAnimator;
}

#pragma mark - Private
static NSString * const kiOSDemos_VCTransitionsResourcesBundleName = @"vc-transitions-oc";
- (UIImage *)imageWithName:(NSString *)name {
    static NSBundle *resourceBundle = nil;
    if (!resourceBundle) {
        NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
        NSString *resourcePath = [mainBundle pathForResource:kiOSDemos_VCTransitionsResourcesBundleName ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:resourcePath] ?: mainBundle;
    }
    UIImage *image = [UIImage imageNamed:name inBundle:resourceBundle compatibleWithTraitCollection:nil];
    return image;
}

#pragma mark - Getter
- (IDJDProductDetailForPresentedAnimator *)presentedAnimator {
    if (!_presentedAnimator) {
        _presentedAnimator = [[IDJDProductDetailForPresentedAnimator alloc] init];
    }
    return _presentedAnimator;
}

- (IDJDProductDetailForDismissedAnimator *)dismissedAnimator {
    if (!_dismissedAnimator) {
        _dismissedAnimator = [[IDJDProductDetailForDismissedAnimator alloc] init];
    }
    return _dismissedAnimator;
}

@end
