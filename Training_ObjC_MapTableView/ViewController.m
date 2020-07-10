//
//  ViewController.m
//  Training_ObjC_MapTableView
//
//  Created by mmslab-mini on 2020/7/10.
//  Copyright © 2020 mmslab-mini. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

//

@interface ViewController ()

/* 控制器上看得到的物件 */
@property (strong,nonatomic) IBOutlet UITableView *stationTable;
@property (strong,nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) IBOutlet UIButton *switchingBtn;
/* 程式會使用到的各類變數 */
@property (strong, nonatomic) NSMutableArray<NSString *> *stationNameArr;
@property (strong, nonatomic) NSMutableArray<NSString *> *stationAddressArr;
@property (strong, nonatomic) NSMutableArray<NSMutableArray<NSNumber *> *> *coordinatesArr;
@property (strong, nonatomic) NSMutableArray<MKPointAnnotation *> *annotationArr;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *array = @[@"taipei",@"taipei"]; // 靜態陣列
    NSArray *array1 = [[NSArray alloc]initWithObjects:@"taipei",@"taipei", nil];
        
     _stationNameArr = @[@"taipei",@"taipei"].mutableCopy;
    _stationNameArr = [[NSMutableArray<NSString *> alloc]initWithArray:@[@"taipei",@"taipei"]];
    _stationNameArr = [[NSMutableArray<NSString *> alloc]initWithObjects:@"taipei",@"taipei", nil];
    
}


@end
