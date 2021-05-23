//
//  IDVCTransitionModel.h
//  vc-transitions-oc
//
//  Created by devyc on 2021/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDVCTransitionModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) Class targetVcClass;

@end

NS_ASSUME_NONNULL_END
