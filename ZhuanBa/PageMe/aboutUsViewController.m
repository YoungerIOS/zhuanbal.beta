//
//  aboutUsViewController.m
//  ZhuanBa
//
//  Created by young on 2018/9/13.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "aboutUsViewController.h"

@interface aboutUsViewController ()

@end

@implementation aboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self initSubviews];
    UIButton * button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(esc) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

-(void)esc{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initSubviews {
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:textView];
    textView.editable = NO;
    textView.text = @"\n        赚吧应用的创作初衷是为了缓解一部分大学生上学给家庭带来的经济压力，让学生们可以充分利用自己的碎片时间和课余假期等时间，通过自己的劳动赚取日常生活费用。这一想法也得到了学校领导、学生联谊会以及广大学子们的大力支持，经过近两个月的设计开发，终于出了第一个版本。希望我们创业团队的努力可以为更多人带来便利，我们也承诺维护好这个App的运作规则和服务环境，防止虚假不良信息，避免给用户造成不必要的麻烦。";
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
