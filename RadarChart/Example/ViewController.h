//
//  ViewController.h
//  RadarChart
//
//  Created by Juan Pablo Illanes Sotta on 06-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPRadarChart.h"

@interface ViewController : UIViewController
{
    RPRadarChart *rc;
}

-(IBAction)blue:(id)sender;
-(IBAction)V1:(id)sender;
-(IBAction)V2:(id)sender;
-(IBAction)RND:(id)sender;

@end
