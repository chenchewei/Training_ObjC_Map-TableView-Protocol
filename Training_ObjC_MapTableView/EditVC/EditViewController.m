//
//  EditViewController.m
//  Training_ObjC_MapTableView
//
//  Created by mmslab-mini on 2020/7/13.
//  Copyright © 2020 mmslab-mini. All rights reserved.
//

#import "EditViewController.h"
#import "ViewController.h"
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

- (void)setInitDataWithArr:(NSMutableArray<NSString *> *)name Address:(NSMutableArray<NSString *> *)addr number:(int)index delegate:(id)delegate{
    _stationNameArr = name;
    _stationAddressArr = addr;
    _number = index;
    _delegate = delegate;
}

- (IBAction)saveBtnClicked:(id)sender {
    if([_nameText.text isEqual: @""] || [_addressText.text isEqual: @""]) {
        _stationNameArr[_number] = _nameText.placeholder;
        _stationAddressArr[_number] = _addressText.placeholder;
    }
    else{
        _stationNameArr[_number] = _nameText.text;
        _stationAddressArr[_number] = _addressText.text;
    }
    
    [_delegate updateDataWithMode:2];   // Mode2: Saved
    
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)cancelBtnClicked:(id)sender {
  
    [_delegate updateDataWithMode:1];   // Mode1: Canceled
    [self.navigationController popViewControllerAnimated:true];
}

@end
