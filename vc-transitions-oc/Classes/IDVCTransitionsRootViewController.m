//
//  IDVCTransitionsRootViewController.m
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/22.
//

#import "IDVCTransitionsRootViewController.h"
#import "IDVCTransitionModel.h"
#import "IDFullScreenAnimator.h"

// 下列为所有转场demo vc
#import "IDSystemPresentationViewController.h"

@interface IDVCTransitionsRootViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) IDFullScreenForPresentedAnimator *presentedAnimator;

@property (nonatomic, strong) IDFullScreenForDismissedAnimator *dismissedAnimator;

@end

@implementation IDVCTransitionsRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"控制器转场示例集";
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.items[section] objectForKey:@"tips"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    IDVCTransitionModel *tsModel = [self.items[indexPath.section] objectForKey:@"tips"][indexPath.row];
    cell.textLabel.text = tsModel.title;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.items[section] objectForKey:@"title"];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IDVCTransitionModel *tsModel = [self.items[indexPath.section] objectForKey:@"tips"][indexPath.row];

    UIViewController *vc = [[tsModel.targetVcClass alloc] init];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentedAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissedAnimator;
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)items {
    if (!_items) {
        _items = @[
            @{
                @"title": @"Modal 转场示例集合",
                @"tips": @[
                    ({
                        IDVCTransitionModel *model = [[IDVCTransitionModel alloc] init];
                        model.title = @"模拟最新系统 present 转场";
                        model.targetVcClass = [IDSystemPresentationViewController class];
                        model;
                    })
                ]
            },
            @{
                @"title": @"Push 转场示例集合"
            },
            @{
                @"title": @"TabBarController 转场示例集合"
            }
        ];
    }
    return _items;
}

- (IDFullScreenForPresentedAnimator *)presentedAnimator {
    if (!_presentedAnimator) {
        _presentedAnimator = [[IDFullScreenForPresentedAnimator alloc] init];
    }
    return _presentedAnimator;
}

- (IDFullScreenForDismissedAnimator *)dismissedAnimator {
    if (!_dismissedAnimator) {
        _dismissedAnimator = [[IDFullScreenForDismissedAnimator alloc] init];
    }
    return _dismissedAnimator;
}

@end
