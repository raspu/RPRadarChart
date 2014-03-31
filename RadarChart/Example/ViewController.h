//
//  ViewController.h
//  RadarChart
//
//  Created by Juan Pablo Illanes Sotta on 06-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPRadarChart.h"

@interface ViewController : UIViewController <RPRadarChartDataSource, RPRadarChartDelegate>
{
    RPRadarChart *rc;
}

-(IBAction)blue:(id)sender;
-(IBAction)V1:(id)sender;
-(IBAction)V2:(id)sender;
-(IBAction)GuideLines:(id)sender;
-(IBAction)GuideNumbers:(id)sender;
-(IBAction)showValues:(id)sender;
-(IBAction)Delegate:(id)sender;
-(IBAction)fillArea:(id)sender;

@end
