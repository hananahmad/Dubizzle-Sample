//
//  ProductDetailViewController.h
//  Classified
//
//  Created by Hanan on 12/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGINs


@interface ProductDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLbl;

@property (strong, nonatomic) NSString *productImage;
@property (strong, nonatomic) NSString *productName;
@property (strong, nonatomic) NSString *productPrice;

@end

//NS_ASSUME_NONNULL_END
