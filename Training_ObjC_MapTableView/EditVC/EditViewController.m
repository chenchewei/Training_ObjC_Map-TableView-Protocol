//
//  EditViewController.m
//  Training_ObjC_MapTableView
//
//  Created by mmslab-mini on 2020/7/13.
//  Copyright © 2020 mmslab-mini. All rights reserved.
//

#import "EditViewController.h"
#import <MapKit/MapKit.h>

@interface EditViewController ()
/* Visible Parameters */
@property (strong,nonatomic) IBOutlet UIButton *saveBtn;
@property (strong,nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *addressText;
/* Received data array */
@property (strong, nonatomic) NSMutableArray<NSString *> *stationNameArr;
@property (strong, nonatomic) NSMutableArray<NSString *> *stationAddressArr;
@property (assign, nonatomic) int number;

@end

@implementation EditViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _nameText.placeholder = _stationNameArr[_number];
    _addressText.placeholder = _stationAddressArr[_number];

}

-(void)setInitDataWithArr:(NSArray<NSString *> *)name Address:(NSArray<NSString *> *)addr number:(int)index {
    _stationNameArr = name;
    _stationAddressArr = addr;
    _number = index;
    
}



- (IBAction)saveBtnClicked:(id)sender {
    _stationNameArr[_number] = _nameText.text;
    _stationAddressArr[_number] = _addressText.text;
    
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)cancelBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}



@end
