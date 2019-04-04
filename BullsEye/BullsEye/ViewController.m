//
//  ViewController.m
//  BullsEye
//
//  Created by 高山明美 on 2019/04/01.
//  Copyright © 2019 festil. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
    int currentValue;
    int targetValue;
    int score;
    int gameRound;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSlider];
    [self startNewRound];
}

- (void)setUpSlider {
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];

    UIEdgeInsets insets = UIEdgeInsetsMake(0, 14, 0, 14);

    UIImage *trackLeftImage = [UIImage imageNamed:@"SliderTrackLeft"];
    UIImage *trackLeftResizable = [trackLeftImage resizableImageWithCapInsets:insets];
    [self.slider setMinimumTrackImage:trackLeftResizable forState:UIControlStateNormal];

    UIImage *trackRightImage = [UIImage imageNamed:@"SliderTrackRight"];
    UIImage *trackRightResizable = [trackRightImage resizableImageWithCapInsets:insets];
    [self.slider setMaximumTrackImage:trackRightResizable forState:UIControlStateNormal];
}

- (void)startNewGame {
    score = 0;
    gameRound = 0;
    [self startNewRound];
}

- (void)startNewRound {
    gameRound += 1;
    targetValue = 1 + arc4random_uniform(100);
    currentValue = 50;
    self.slider.value = (float) currentValue;
    [self updateLabels];
}

- (void)updateLabels {
    self.targetLabel.text = [NSString stringWithFormat:@"%i", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%i", gameRound];
}

- (IBAction)showAlert {
    const int difference = abs(targetValue - currentValue);
    int points = 100 - difference;
    
    score += points;
    
    NSString *title;
    if (difference == 0) {
        title = @"パーフェクト(^^)b!";
        points += 100;
    } else if (difference < 5) {
        title = @"惜しい!";
        if (difference == 1) {
            points += 50;
        }
    } else if (difference < 10) {
        title = @"まあまあ!";
    } else {
        title = @"残念・・・全然・・・";
    }
    NSString *message = [NSString stringWithFormat:@"You scored %i points",points];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       [self startNewRound];
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [self startNewRound];
}

- (IBAction)sliderMoved:(UISlider *) slider {
    currentValue = (int) lroundf(slider.value);
}

- (IBAction)startOver:(UIButton *) sender {
    [self startNewGame];
}

@end
