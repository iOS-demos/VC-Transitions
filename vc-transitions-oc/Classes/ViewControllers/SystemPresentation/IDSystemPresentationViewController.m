//
//  IDSystemPresentationViewController.m
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/22.
//

#import "IDSystemPresentationViewController.h"
#import "IDSystemPresentationAnimator.h"
#import "IDSystemPersentationInteractiveTransition.h"
#import "IDSystemPresentationInnerTableView.h"

#define IDRandomColor [UIColor colorWithHue:(arc4random() % 256 / 256.0) saturation:( arc4random() % 128 / 256.0 ) + 0.5 brightness:( arc4random() % 128 / 256.0 ) + 0.5 alpha:1]

@interface IDSystemPresentationViewController () <UITableViewDataSource, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) IDSystemPersentationInteractiveTransition *spInteractiveTrans;

@property (nonatomic, strong) IDSystemPresentationInnerTableView *tableView;

@end

@implementation IDSystemPresentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = IDRandomColor;
    
    UIButton *presentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [presentBtn setTitle:@"present" forState:UIControlStateNormal];
    [presentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:presentBtn];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:dismissBtn];
    
    presentBtn.frame = CGRectMake(0, 0, 100, 50);
    dismissBtn.frame = CGRectMake(0, 0, 100, 50);
    presentBtn.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
    dismissBtn.center = CGPointMake(presentBtn.center.x, presentBtn.center.y + 60);
    
    presentBtn.backgroundColor = [UIColor blueColor];
    dismissBtn.backgroundColor = [UIColor systemPinkColor];
    
    [presentBtn addTarget:self action:@selector(presentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.addTableView) {
        [self.view insertSubview:self.tableView atIndex:0];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - Events
- (void)presentBtnClick {
    IDSystemPresentationViewController *spVc = [[IDSystemPresentationViewController alloc] init];
    spVc.addTableView = YES;
    spVc.transitioningDelegate = self;
    spVc.modalPresentationStyle = UIModalPresentationCustom;
    [self.spInteractiveTrans setPresentedViewController:spVc];
    [self presentViewController:spVc animated:YES completion:nil];
}

- (void)dismissBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[IDSystemPresentationForPresentedAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[IDSystemPresentationForDismissedAnimator alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.spInteractiveTrans.interacting ? self.spInteractiveTrans : nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%lu", indexPath.row];
    return cell;
}

#pragma mark - Getter
- (IDSystemPersentationInteractiveTransition *)spInteractiveTrans {
    if (!_spInteractiveTrans) {
        _spInteractiveTrans = [[IDSystemPersentationInteractiveTransition alloc] init];
    }
    return _spInteractiveTrans;
}

- (IDSystemPresentationInnerTableView *)tableView {
    if (!_tableView) {
        _tableView = [[IDSystemPresentationInnerTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.bounces = NO;
    }
    return _tableView;
}

@end
