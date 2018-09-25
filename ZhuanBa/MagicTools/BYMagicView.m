//
//  BYMagicViewController.m
//  Weather
//
//  Created by young on 2018/8/17.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYMagicView.h"
#import <WebKit/WebKit.h>
#import "BottomToolbar.h"
#import "SVProgressHUD.h"


@interface BYMagicView ()<WKNavigationDelegate,UIWebViewDelegate,BottomToolbarDelegate>

@property (nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong)  UIWebView      *webView;
@property(nonatomic, strong)  BottomToolbar  *bottomBar;
@property (nonatomic, strong) NSTimer        *progressTimer;

@end

@implementation BYMagicView
- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showMagicSpaceWithUrlString:self.magicString];
    
}

- (void)showMagicSpaceWithUrlString:(NSString *)string {
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *))
    {
        safeAreaInsets = self.view.safeAreaInsets;
    }
    self.webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44.0 - safeAreaInsets.bottom);
    [self.view addSubview:self.webView];
    
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    
    [self.progressView setTintColor:[UIColor yellowColor]];
    self.progressView.frame = CGRectMake(0, safeAreaInsets.top, CGRectGetWidth(self.view.bounds),3);
    [self.webView addSubview:self.progressView];
    
    self.bottomBar.delegate = self;
    [self.view addSubview:self.bottomBar];
    
    self.magicString = string;
    NSURL *urlString = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
    [self.webView loadRequest:request];
    
}

-(UIImage *)getLaunchImage
{
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        viewOrientation = @"Landscape";
    }
    
    NSString *launchImageName = @"";
    NSArray *imageArr = [NSBundle mainBundle].infoDictionary[@"UILaunchImages"];
    UIWindow *currentWindow = [UIApplication sharedApplication].windows.firstObject;
    CGSize viewSize = currentWindow.bounds.size;
    
    for (NSUInteger i = 0; i < [imageArr count]; i++)
    {
        NSDictionary *imageDic = imageArr[i];
        NSString *sizeStr = imageDic[@"UILaunchImageSize"];
        CGSize imageSize = CGSizeFromString(sizeStr);
        if ( CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation compare:imageDic[@"UILaunchImageOrientation"]] == NSOrderedSame)
        {
            launchImageName = imageDic[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImageName];
}



#pragma mark - bottomBarDelegate
- (void)toolbar:(BottomToolbar *)webToolbar event:(LKToolbarEvent)event
{
    switch (event)
    {
        case BottomToolbarHomeEvent:
            [self backHome];
            break;
            
        case BottomToolbarBackEvent:
            if ([self.webView canGoBack])
            {
                [self.webView goBack];
            }
            break;
            
        case BottomToolbarNextEvent:
            if ([self.webView canGoForward])
            {
                [self.webView goForward];
            }
            break;
            
        case BottomToolbarRefreshEvent:
            [self.webView reload];
            break;
            
        case BottomToolbarClearEvent:
            [self removeWebCache];
            break;
    }
}

#pragma mark - 回到主页
- (void)backHome
{
    NSURL *htmlURL = [NSURL URLWithString:self.magicString];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    [self.webView loadRequest:request];
}
//判断底部操作栏状态
- (void)adjustState
{
    if (_bottomBar)
    {
        self.bottomBar.backButton.enabled = [self.webView canGoBack];
        self.bottomBar.forwardButton.enabled = [self.webView canGoForward];
    }
}
#pragma mark - 清除缓存
- (void)removeWebCache
{
    if (@available(iOS 9.0, *))
    {
        NSSet *websiteDataTypes= [NSSet setWithArray:@[
                                                       WKWebsiteDataTypeDiskCache,
                                                       WKWebsiteDataTypeOfflineWebApplicationCache,
                                                       WKWebsiteDataTypeMemoryCache,
                                                       //WKWebsiteDataTypeCookies,
                                                       WKWebsiteDataTypeSessionStorage,
                                                       WKWebsiteDataTypeIndexedDBDatabases,
                                                       WKWebsiteDataTypeWebSQLDatabases
                                                       ]];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            [SVProgressHUD showSuccessWithStatus:@"已清除"];
        }];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }
    else
    {
        //先删除cookie
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            [storage deleteCookie:cookie];
        }
        
        NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        //        NSString *webKitFolderInCachesfs = [NSString
        //        stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
        NSError *error;
        /* iOS8.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        [SVProgressHUD showSuccessWithStatus:@"已清除"];
    }
}
#pragma mark - webviewdelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* reqUrl = request.URL.absoluteString;
    //支付宝
    if ([reqUrl hasPrefix:@"alipays://"] || [reqUrl hasPrefix:@"alipay://"])
    {
        if (@available(iOS 10.0, *))
        {
            [[UIApplication sharedApplication] openURL:request.URL options:@{@"":@""} completionHandler:nil];
        }
        else
        {
//            BOOL bsucces = [[UIApplication sharedApplication] openURL:request.URL];
        }
        return YES;
    }
    if ([reqUrl hasPrefix:@"weixin://"])
    {
        if (@available(iOS 10.0, *))
        {
            [[UIApplication sharedApplication] openURL:request.URL options:@{@"":@""} completionHandler:nil];
        }
        else
        {
//            BOOL bsucces = [[UIApplication sharedApplication] openURL:request.URL];
        }
        return YES;
    }
    [self fakeProgressViewStartLoading];
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error
{
    [SVProgressHUD dismiss];
    if(!self.webView.isLoading)
    {
        [self fakeProgressBarStopLoading];
    }
    if (_bottomBar) [self adjustState];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
    [SVProgressHUD dismiss];
    if(!self.webView.isLoading)
    {
        [self fakeProgressBarStopLoading];
    }
    
    if (_bottomBar) [self adjustState];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self fun_setWebFrame];
}

- (void)fun_setWebFrame
{
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *))
    {
        safeAreaInsets = self.view.safeAreaInsets;
    }
    CGRect frame = CGRectMake(0.0, CGRectGetHeight(self.view.bounds) - 44.0 - safeAreaInsets.bottom, CGRectGetWidth(self.view.bounds), 44.0);
    _bottomBar.frame=frame;
    [_bottomBar setHidden:NO];
    self.webView.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44.0 - safeAreaInsets.bottom - [[UIApplication sharedApplication] statusBarFrame].size.height - 1);
    self.bottomBar.frame = CGRectMake(0.0, CGRectGetHeight(self.view.bounds) - 44.0 - safeAreaInsets.bottom, CGRectGetWidth(self.view.bounds), 44.0);
    self.progressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),3);
}

#pragma mark - Fake Progress Bar Control (UIWebView)
- (void)fakeProgressViewStartLoading
{
    [self.progressView setProgress:0.0f animated:NO];
    [self.progressView setAlpha:1.0f];
    
    if(!self.progressTimer)
    {
        self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
    }
}

- (void)fakeProgressBarStopLoading
{
    if(self.progressTimer)
    {
        [self.progressTimer invalidate];
    }
    
    if(self.progressView)
    {
        [self.progressView setProgress:1.0f animated:YES];
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)fakeProgressTimerDidFire:(id)sender
{
    CGFloat increment = 0.005/(self.progressView.progress + 0.2);
    if([self.webView isLoading])
    {
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        if(self.progressView.progress < 0.95)
        {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

- (BottomToolbar *)bottomBar
{
    if (!_bottomBar)
    {
        UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *))
        {
            safeAreaInsets = self.view.safeAreaInsets;
        }
        CGRect frame = CGRectMake(0.0, CGRectGetHeight(self.view.bounds) - 44.0 - safeAreaInsets.bottom, CGRectGetWidth(self.view.bounds), 44.0);
        _bottomBar = [[BottomToolbar alloc] initWithFrame:frame];
        _bottomBar.delegate = self;
    }
    return _bottomBar;
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
