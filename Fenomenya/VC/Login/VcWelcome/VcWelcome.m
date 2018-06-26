//
//  VcWelcome.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "VcWelcome.h"
#import "VcLogin.h"
#import "VcFenomenia.h"

@interface VcWelcome ()
{
	int  currentPage;
	BOOL pageControlUsed;
}
@end

@implementation VcWelcome

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	CGSize size = self.scrView.frame.size;
	size.width *= 4;
	self.scrView.contentSize = size;
	
	self.scrView.clipsToBounds = NO;
	self.scrView.contentInset = UIEdgeInsetsZero;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginSuccesful:) name:@"RegisterByMail" object:nil];

	
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

#pragma mark Page Control Event
-(IBAction)PageControlValueChanged:(id)sender
{
	NSInteger sayfa = self.pageControl.currentPage;
	
	// Kayar paneli ilgili sayfaya kaydır
	CGRect frame = self.scrView.frame;
	frame.origin.x = frame.size.width * sayfa;
	frame.origin.y = 0;
	[self.scrView scrollRectToVisible:frame animated:YES];
	
	[self.pageControl setCurrentPage:sayfa];
	// Kaydırma işleminin UIPageControl nesnesi tarafından başlatıldığını belirten bayrağı 1 yap
	pageControlUsed = YES;
}

#pragma mark ScrollView Delegates
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
/*	// Eğer sayfa çevirme işlemi kullanıcının paneli kaydırması ile değil, pageControl nesnesi ile yapılmışsa hiçbir şey yapma
	if (pageControlUsed) return;
	
	// Önceki yada sonraki sayfanın yarısından fazlası görünür hale gelmişse pageControl nesnesinin sayfa göstergesini güncelle
	float pageWidth = self.scrView.frame.size.width;
	int page = floor((self.scrView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	self.pageControl.currentPage = page;*/
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	pageControlUsed = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[self SetScrollPosition];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
	[self SetScrollPosition];
}

-(void)SetScrollPosition
{
	float scrWidth = self.scrView.frame.size.width;
	currentPage = floor( self.scrView.contentOffset.x / scrWidth );
	[self.pageControl setCurrentPage:currentPage];
	/*
	bool ileri = false;
	float f = self.scrView.contentOffset.x - currentPage*scrWidth;
	
	if(f > 0) ileri = true;
	
	f = fabsf(f);
	if(f > scrWidth)
	{
		int x = floor(f/scrWidth);
		f = f - (x * scrWidth);
	}
	
	currentPage = ceil(self.scrView.contentOffset.x/scrWidth);
	
	if(ileri)
	{
		if(f > scrWidth/2)
		{
			//currentPage;
		}
		else
		{
			currentPage--;
		}
	}
	else
	{
		if(f > scrWidth/2)
		{
			currentPage--;
		}
		else
		{
			//	currentPage--;
		}
	}
	
	
	[self.pageControl setCurrentPage:currentPage];
	
	
	[self.scrView setContentOffset:CGPointMake(scrWidth*(currentPage), 0) animated:YES];
	
	pageControlUsed = NO;*/
}

#pragma mark Action Login
-(IBAction)ActionLogin:(id)sender
{
	VcLogin * vcLogin = [[VcLogin alloc] initWithNibName:@"VcLogin" bundle:nil];
	[self presentViewController:vcLogin animated:YES
					 completion:^{
						 
					 } ];
}

#pragma mark Action Register
-(IBAction)ActionRegister:(id)sender
{
	
	
}


#pragma mark Login Succesful
-(void)LoginSuccesful:(NSNotification*)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:@"RegisterByMail"
												  object:nil];
	
	VcFenomenia *vcFenomenia = [[VcFenomenia alloc] initWithNibName:@"VcFenomenia" bundle:nil];
	[self.navigationController pushViewController:vcFenomenia animated:YES];
	
	
}
@end
