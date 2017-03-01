//
//  OneVC.m
//  DeepLinkingDemo
//
//  Created by Liuguiliang on 2017/3/1.
//  Copyright © 2017年 HuiDragon. All rights reserved.
//

#import "OneVC.h"

@interface OneVC ()

@end

@implementation OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)threeVC:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"dlapp://page/page3"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
