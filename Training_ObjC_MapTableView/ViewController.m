//
//  ViewController.m
//  Training_ObjC_MapTableView
//
//  Created by mmslab-mini on 2020/7/10.
//  Copyright © 2020 mmslab-mini. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "EditViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,EditViewControllerDelegate>

/* 控制器上看得到的物件 */
@property (strong,nonatomic) IBOutlet UITableView *stationTable;
@property (strong,nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) IBOutlet UIButton *switchingBtn;
/* 程式會使用到的各類變數 */
@property (strong, nonatomic) NSMutableArray<NSString *> *stationNameArr;
@property (strong, nonatomic) NSMutableArray<NSString *> *stationAddressArr;
@property (strong, nonatomic) NSArray<NSArray<NSNumber *> *> *coordinatesArr;
@property (strong, nonatomic) NSMutableArray<MKPointAnnotation *> *annotationArr;
@property (assign, nonatomic) int number;
// Return flag
@property (assign,nonatomic) bool isReturned;

@end

@implementation ViewController

#pragma mark - environments setup
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    [self setAnnotation];
}

// Everytime back to this VC, reload everything
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(_isReturned) {
        [self deleteAllAnnotation];
        [_stationTable reloadData];
        [self setAnnotation];
        _isReturned = false;
    }
    else{
        NSLog(@"No data returned.");
    }
    
}

/* Initializing datas */
-(void)dataInit {
    _stationNameArr = @[@"南港",@"台北",@"板橋",@"桃園",@"新竹",@"苗栗",@"台中",@"彰化",@"雲林",@"嘉義",@"台南",@"左營"].mutableCopy;
    _stationAddressArr = @[@"台北市南港區南港路一段313號",@"台北市北平西路3號",@"新北市板橋區縣民大道二段7號",@"桃園市中壢區高鐵北路一段6號",@"新竹縣竹北市高鐵七路6號",@"苗栗縣後龍鎮高鐵三路268號",@"台中市烏日區站區二路8號",@"彰化縣田中鎮站區路二段99號",@"雲林縣虎尾鎮站前東路301號",@"嘉義縣太保市高鐵西路168號",@"台南市歸仁區歸仁大道100號",@"高雄市左營區高鐵路105號"].mutableCopy;
    _coordinatesArr = @[ @[@(25.053188323974609),@(121.60706329345703)], @[@(25.047670364379883),@(121.51698303222656)] , @[@(25.013870239257813),@(121.46459197998047)], @[@(25.012861251831055),@(121.21472930908203)], @[@(24.808441162109375),@(121.04026031494141)], @[@(24.605447769165039),@(120.82527160644531)], @[@(24.112483978271484),@(120.615966796875)], @[@(23.874326705932617),@(120.57460784912109)], @[@(23.736230850219727),@(120.41651153564453)], @[@(23.459506988525391),@(120.32325744628906)], @[@(22.925077438354492),@(120.28620147705078)], @[@(22.68739128112793),@(120.30748748779297)] ];
    _annotationArr = [NSMutableArray<MKPointAnnotation *> new];
    _stationTable.hidden = true;
    _isReturned = false;
    _stationTable.delegate = self;
    _mapView.delegate = self;
}

-(void)setAnnotation {
    for(int i=0; i<_stationNameArr.count; i++) {
        MKPointAnnotation *annotation = [MKPointAnnotation new];
        annotation.title = _stationNameArr[i];
        annotation.subtitle = _stationAddressArr[i];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([_coordinatesArr[i][0] doubleValue],[_coordinatesArr[i][1] doubleValue]);
        annotation.coordinate = coord;
        _annotationArr[i] = annotation;
    }
    [_mapView addAnnotations: _annotationArr];
}

- (void)deleteAllAnnotation {
    NSMutableArray *allAnnotation =(NSMutableArray *) _mapView.annotations;
    [_mapView removeAnnotations:allAnnotation];

}

#pragma mark - Main actions
// 切換 Map/TableView 顯示
- (IBAction)switchBtnClicked:(UIButton *) switchingBtn{
    _stationTable.hidden = !_stationTable.hidden;
}
// Popup alert view
-(void) mapView:(MKMapView *)_mapView didSelectAnnotationView:(MKAnnotationView *)view {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:((void)(@"%@"),view.annotation.title) message:((void)(@"%@"),view.annotation.subtitle) preferredStyle:UIAlertControllerStyleAlert];
    // Get index
    for(_number=0; _number<_annotationArr.count;_number++) {
        if(_annotationArr[_number].title == view.annotation.title){
            break;
        }
    }
    

    UIAlertAction *nameAction = [UIAlertAction actionWithTitle:@"編輯" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        EditViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
        
        [editVC setInitDataWithArr:self.stationNameArr Address:self.stationAddressArr number:self.number delegate:(id)self];
        
        
        
        
        
        
        
        
        
        [self.navigationController pushViewController:editVC animated: true];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertViewController addAction:nameAction];
    [alertViewController addAction:cancelAction];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}


#pragma mark - tableview setup
-(NSInteger)tableView: (UITableView *) stationTable numberOfRowsInSection:(NSInteger)section {
    return _stationNameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *) _stationTable cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_stationTable dequeueReusableCellWithIdentifier:@"reuseCell"];
    // 注意：detailTextLabel並不會跟隨init一起初始化，需要另外設置
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseCell"];
    if (cell == nil) {
        //若沒有可用的Cell 則初始化一個Cell並設定reuse ID
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseCell"];
    }
    cell.textLabel.text = _stationNameArr[indexPath.row];
    cell.detailTextLabel.text = _stationAddressArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *) _stationTable didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    printf("Clicked No. %d cell.\n",(int)indexPath.row);
    [_stationTable deselectRowAtIndexPath:indexPath animated:true];
}
#pragma mark - Protocol returned
- (void)updateDataWithMode:(int)mode{
    if(mode == 2){
        _isReturned = true;
    }
}


@end
