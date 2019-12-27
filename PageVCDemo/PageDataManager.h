//
//  PageDataManager.h
//  PageContrlVCDemo
//
//  Created by lotus on 2019/12/26.
//  Copyright © 2019 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PageDataManager : NSObject<UIPageViewControllerDataSource>

///获取视图控制器
- (DataViewController *)viewContrllerAtIndex:(NSInteger)index stroyBoard:(UIStoryboard *)storyboard;
///获取某个视图控制器在数组中的位置
- (NSInteger)indexOfViewController:(DataViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
