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

@end

@implementation IDVCTransitionsRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"控制器转场示例集";
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    IDVCTransitionModel *tsModel = self.items[indexPath.row];
    cell.textLabel.text = tsModel.title;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [[[self.items[indexPath.row] targetVcClass] alloc] init];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[IDFullScreenForPresentedAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[IDFullScreenForDismissedAnimator alloc] init];
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
            ({
                IDVCTransitionModel *model = [[IDVCTransitionModel alloc] init];
                model.title = @"模拟最新系统 present 转场";
                model.targetVcClass = [IDSystemPresentationViewController class];
                model;
            })
        ];
    }
    return _items;
}

@end
