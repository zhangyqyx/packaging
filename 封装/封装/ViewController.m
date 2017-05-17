//
//  ViewController.m
//  封装
//
//  Created by 张永强 on 17/3/30.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "TFArbitrarilyButton.h"
#import "NSDate+TFDate.h"
#import "UIImage+TFFunction.h"
#import "MacroDefinition.h"
#import "UIColor+TFColor.h"
#import "TFMemorySize.h"
#import "TFFileManager.h"
#import "UIViewController+TFTransitionAnimation.h"


@interface ViewController ()

/**按钮 */
@property (nonatomic , strong)UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)gotoNext:(id)sender {

}


- (IBAction)first:(id)sender {
    TFLog(@"1");
}
- (IBAction)second:(id)sender {
    NSLog(@"2");
}
- (IBAction)three:(id)sender {
    NSLog(@"3");
}
- (IBAction)four:(id)sender {
    NSLog(@"4");
}
- (IBAction)five:(id)sender {
    NSLog(@"5");
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
