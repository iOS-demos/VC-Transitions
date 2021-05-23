//
//  IDJDProductDetailMoreViewController.m
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/23.
//

#import "IDJDProductDetailMoreViewController.h"

@interface IDJDProductDetailMoreViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation IDJDProductDetailMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    
    self.imageView.image = [self imageWithName:@"jd-product-detail-more"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.imageView.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
