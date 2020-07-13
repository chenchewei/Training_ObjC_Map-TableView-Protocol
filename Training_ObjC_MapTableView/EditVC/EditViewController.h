//
//  EditViewController.h
//  Training_ObjC_MapTableView
//
//  Created by mmslab-mini on 2020/7/13.
//  Copyright © 2020 mmslab-mini. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EditViewControllerDelegate <NSObject>
@end


@interface EditViewController : UIViewController

@property (weak ,nonatomic) id<EditViewControllerDelegate> delegate;
- (void)setInitDataWithArr:(NSMutableArray<NSString *> *)name Address:(NSMutableArray<NSString *> *)addr number:(int)index;

@end


