//
//  ViewController.m
//  TwitterShare
//
//  Created by Lucas Yang on 2017-06-06.
//  Copyright © 2017 LuFi Coop Inc. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
- (void) configureTweetTextView;
- (void) showALertMessage:(NSString*)sendMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTweetTextView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showALertMessage:(NSString*)sendMessage
{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"Social Share" message:sendMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OKEY" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)showShareAction:(id)sender {
    
    if([self.tweetTextView isFirstResponder])
        [self.tweetTextView resignFirstResponder];
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Test Title" message:@"Share in social media" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                
                SLComposeViewController *twitterComposeVC =
                    [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                if ([self.tweetTextView.text length] <= 140) {
                    [twitterComposeVC setInitialText:self.tweetTextView.text];
                }
                else{
                    NSString *subText = [self.tweetTextView.text substringFromIndex:140];
                    [twitterComposeVC setInitialText:subText];
                }
                
                [self presentViewController:twitterComposeVC animated:YES completion:nil];
            }
            else{
                [self showALertMessage:@"Please sign in to twitter first"];
            }
        
    }];
    
    
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            
            SLComposeViewController *facebookComposeVC =
            [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            if ([self.tweetTextView.text length] <= 140) {
                [facebookComposeVC setInitialText:self.tweetTextView.text];
            }
            else{
                NSString *subText = [self.tweetTextView.text substringFromIndex:140];
                [facebookComposeVC setInitialText:subText];
            }
            
            [self presentViewController:facebookComposeVC animated:YES completion:nil];
        }
        else{
            [self showALertMessage:@"Please sign in to facebook first"];
        }
        
    }];
    
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"More" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
            UIActivityViewController *moreVC =
        [[UIActivityViewController alloc] initWithActivityItems:@[self.tweetTextView.text] applicationActivities:nil];
        
            [self presentViewController:moreVC animated:YES completion:nil];
        
    }];

    
    [actionController addAction:tweetAction];
    [actionController addAction:facebookAction];
    [actionController addAction:moreAction];
    [actionController addAction:cancelAction];
    
    [self presentViewController:actionController animated:YES completion:nil];
}

- (void) configureTweetTextView
{
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
}

@end
