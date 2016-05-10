//
//  LSSendViewController.m
//  梁森微博
//
//  Created by 梁森 on 16/5/9.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSSendViewController.h"
//#import "UIBarButtonItem+Item.h"
// 发送文本框
#import "LSTextView.h"
// 发送工具条
#import "LSSendToolBar.h"
#import "LSPicturesView.h"

#import "LSStatusTool.h"

#import "LSAccount.h"
#import "LSAccountTool.h"

#import "AFNetworking.h"
// 活动指示器
#import "SVProgressHUD.h"
@interface LSSendViewController ()<UITextViewDelegate, LSSendToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  发送框
 */
@property (nonatomic, strong) LSTextView * textView;
/**
 *  发送工具条
 */
@property (nonatomic, strong) LSSendToolBar * toolBar;
/**
 *  相册视图
 */
@property (nonatomic, strong) LSPicturesView * pictures;
/**
 *  装图片的数组
 */
@property (nonatomic, strong) NSMutableArray * images;

@end

@implementation LSSendViewController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"发送微博";
    // 设置导航条上的左右侧按钮
    [self setUpLeftAndRightItem];
    // 设置发送文本框
    [self setUpTextView];
    // 设置发送工具条
    [self setUpSendToolBar];
    // 设置图片视图
    [self setUpPicturesView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [_textView becomeFirstResponder];
}
- (void)setUpLeftAndRightItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    UIButton * rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:@"发送" forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightItem sizeToFit];
    // 为按钮添加点击事件
    [rightItem addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setUpTextView
{
    LSTextView * textView = [[LSTextView alloc] initWithFrame:self.view.bounds];
    // 允许textView垂直方向拖动
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    // 占位符内容
    textView.placeholder = @"占位符内容";
    // 文字内容大小
    textView.font = [UIFont systemFontOfSize:15];
    
    // 对UITextView添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged) name:UITextViewTextDidChangeNotification object:nil];
    
    textView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:textView];
    _textView = textView;

}

- (void)setUpSendToolBar
{
    LSSendToolBar * toolBar = [[LSSendToolBar alloc] initWithFrame:CGRectMake(0, HEIGHT - 35, WIDTH, 35)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    // 对键盘添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setUpPicturesView
{
    LSPicturesView * pictures = [[LSPicturesView alloc] initWithFrame:CGRectMake(0, 70, WIDTH, HEIGHT - 70)];
    pictures.backgroundColor = [UIColor redColor];
    [_textView addSubview:pictures];
    _pictures = pictures;
}

// 键盘发生变化后通知
- (void)keyBoardChanged:(NSNotification *)note
{
    // 键盘的大小
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 键盘出现的时长
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    if (frame.origin.y == self.view.height) {   // 当键盘没有弹出的时候
        
        [UIView animateWithDuration:duration animations:^{
            
            _toolBar.transform = CGAffineTransformIdentity;
        }];
    } else
    {
        [UIView animateWithDuration:duration animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}

// textView的内容发生变化后进行调用
- (void)textViewChanged
{
    // 如果有内容就隐藏占位符，没有内容就显示占位符
    if (_textView.text.length) {
        _textView.hidePlaceHolder = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else
    {
        _textView.hidePlaceHolder = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 发送按钮的点击事件
- (void)send
{
    // 有图片发送图片
    if (self.images.count) {
        [self sendPictures];
    } else
    {
        [self sendText];
    }
   
}
// 发送图片
- (void)sendPictures
{
    NSString * text = _textView.text.length ? _textView.text : @"分享图片";
    
    
//    for (int i = 0; i < self.images.count; i ++) {
        UIImage * image = self.images[0];
        [LSStatusTool composeWithStatus:text image:image success:^{
            
            NSLog(@"上传图片成功...");
            [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
            NSLog(@"上传图片的错误信息：%@", error);
        }];
//    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
// 发送文字
- (void)sendText
{
    LSAccount * account = [LSAccountTool account];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    NSLog(@"access——token%@", account.access_token);
    parameters[@"access_token"] = account.access_token;
    parameters[@"status"] = _textView.text;
    [LSStatusTool PostText:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters success:^(id resposeObject) {
        
        NSLog(@"发送文字成功...");
    } failure:^(NSError * error) {
        
        NSLog(@"错误信息：%@", error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -------- UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [_textView resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark -------- LSSendToolBarDelegate
- (void)sendToolBarWithBtn:(NSInteger)index
{
    if (index == 0) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
#pragma mark -------- UIImagePickerControllerDelegate  选择图片完成的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 获取到选择的图片
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    [self.images addObject:image];
    
    _pictures.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
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
