#import "AccessApplyModel.h"
@implementation AccessApplyModel
-(NSString *)carDealerCodeStr
{
    if (!_carDealerCodeStr) {
        if (_carDealerArray.count > 0) {
            for (int i = 0; i < _carDealerArray.count; i ++) {
                if ([_carDealerCode isEqualToString:_carDealerArray[i][@"code"]]) {
                    _carDealerCodeStr = _carDealerArray[i][@"fullName"];
                }
            }
        }else
        {
            TLNetworking *http = [TLNetworking new];
            http.isShowMsg = YES;
            http.code = @"632067";
            http.parameters[@"curNodeCode"] = @"006_03";
            [http postWithSuccess:^(id responseObject) {
                _carDealerArray = responseObject[@"data"];
                for (int i = 0; i < _carDealerArray.count; i ++) {
                    if ([_carDealerCode isEqualToString:_carDealerArray[i][@"code"]]) {
                        _carDealerCodeStr = _carDealerArray[i][@"fullName"];
                    }
                }
            } failure:^(NSError *error) {
            }];
        }
    }
    return _carDealerCodeStr;
}
-(NSString *)shopWayStr
{
    if (!_shopWayStr) {
        if ([_shopWay isEqualToString:@"1"]) {
            _shopWayStr = @"新车";
        }else
        {
            _shopWayStr = @"二手车";
        }
    }
    return _shopWayStr;
}
- (NSArray *)housePropertyPics {
    if (!_housePropertyPics) {
        NSArray *imgs = [self.houseProperty componentsSeparatedByString:@"||"];
        _housePropertyPics = imgs;
    }
    return _housePropertyPics;
}
- (NSArray *)licensePics {
    if (!_licensePics) {
        NSArray *imgs = [_license componentsSeparatedByString:@"||"];
        _licensePics = imgs;
    }
    return _licensePics;
}
- (NSArray *)driceLicensePics {
    if (!_driceLicensePics) {
        if ([_driceLicense isEqualToString:@""] || [_driceLicense isEqualToString:@"||"]) {
            _driceLicensePics = nil;
        }
        else
        {
            NSArray *imgs = [_driceLicense componentsSeparatedByString:@"||"];
            _driceLicensePics = imgs;
        }
    }
    return _driceLicensePics;
}
- (NSArray *)siteProvePics {
    if (!_siteProvePics) {
        if ([_siteProve isEqualToString:@""] || [_siteProve isEqualToString:@"||"]) {
            _siteProvePics = nil;
        }
        else
        {
            NSArray *imgs = [_siteProve componentsSeparatedByString:@"||"];
            _siteProvePics = imgs;
        }
    }
    return _siteProvePics;
}
-(NSString *)carTypeStr
{
    if (!_carTypeStr) {
        if ([_carType isEqualToString:@"0"]) {
            _carTypeStr = @"自有";
        }
        if ([_carType isEqualToString:@"1"]) {
            _carTypeStr = @"租用";
        }
        if ([_carType isEqualToString:@"2"]) {
            _carTypeStr = @"无";
        }
    }
    return _carTypeStr;
}
- (NSArray *)marryDivorcePics {
    if (!_marryDivorcePics) {
        if ([_marryDivorce isEqualToString:@""] || [_marryDivorce isEqualToString:@"||"]) {
            _marryDivorcePics = nil;
        }
        else
        {
            NSArray *imgs = [_marryDivorce componentsSeparatedByString:@"||"];
            WGLog(@"%@",_marryDivorce);
            _marryDivorcePics = imgs;
        }
    }
    return _marryDivorcePics;
}
- (NSArray *)applyUserHkbPics {
    if (!_applyUserHkbPics) {
        if ([_applyUserHkb isEqualToString:@""] || [_applyUserHkb isEqualToString:@"||"]) {
            _applyUserHkbPics = nil;
        }
        else
            {
            _applyUserHkbPics = [_applyUserHkb componentsSeparatedByString:@"||"];
            }
    }
    return _applyUserHkbPics;
}
- (NSArray *)bankBillPdfPics {
    if (!_bankBillPdfPics) {
        if ([_bankBillPdf isEqualToString:@""] || [_bankBillPdf isEqualToString:@"||"]) {
            _bankBillPdfPics = nil;
        }
        else
            {
            NSArray *imgs = [_bankBillPdf componentsSeparatedByString:@"||"];
            _bankBillPdfPics = imgs;
            }
    }
    return _bankBillPdfPics;
}
- (NSArray *)singleProvePdfPics {
    if (!_singleProvePdfPics) {
        if ([_singleProvePdf isEqualToString:@""] || [_singleProvePdf isEqualToString:@"||"]) {
            _singleProvePdfPics = nil;
        }
        else
        {
            NSArray *imgs = [_singleProvePdf componentsSeparatedByString:@"||"];
            _singleProvePdfPics = imgs;
        }
    }
    return _singleProvePdfPics;
}
- (NSArray *)incomeProvePdfPics {
    if (!_incomeProvePdfPics) {
        if ([_incomeProvePdf isEqualToString:@""] || [_incomeProvePdf isEqualToString:@"||"]) {
            _incomeProvePdfPics = nil;
        }
        else
            {
            NSArray *imgs = [_incomeProvePdf componentsSeparatedByString:@"||"];
            _incomeProvePdfPics = imgs;
            }
    }
    return _incomeProvePdfPics;
}
- (NSArray *)liveProvePdfPics {
    if (!_liveProvePdfPics) {
        if ([_liveProvePdf isEqualToString:@""] || [_liveProvePdf isEqualToString:@"||"]) {
            _liveProvePdfPics = nil;
        }
        else
            {
            NSArray *imgs = [_liveProvePdf componentsSeparatedByString:@"||"];
            _liveProvePdfPics = imgs;
            }
    }
    return _liveProvePdfPics;
}
- (NSArray *)houseInvoicePics {
    if (!_houseInvoicePics) {
        if ([_houseInvoice isEqualToString:@""] || [_houseInvoice isEqualToString:@"||"]) {
            _houseInvoicePics = nil;
        }
        else
            {
            NSArray *imgs = [_houseInvoice componentsSeparatedByString:@"||"];
            _houseInvoicePics = imgs;
            }
    }
    return _houseInvoicePics;
}
- (NSArray *)buildProvePdfPics {
    if (!_buildProvePdfPics) {
        if ([_buildProvePdf isEqualToString:@""] || [_buildProvePdf isEqualToString:@"||"]) {
            _buildProvePdfPics = nil;
        }
        else
            {
            NSArray *imgs = [_buildProvePdf componentsSeparatedByString:@"||"];
            _buildProvePdfPics = imgs;
            }
    }
    return _buildProvePdfPics;
}
- (NSArray *)hkbFirstPagePics {
    if (!_hkbFirstPagePics) {
        if ([_hkbFirstPage isEqualToString:@""] || [_hkbFirstPage isEqualToString:@"||"]) {
            _hkbFirstPagePics = nil;
        }
        else
            {
            NSArray *imgs = [_hkbFirstPage componentsSeparatedByString:@"||"];
            _hkbFirstPagePics = imgs;
 }
    }
    return _hkbFirstPagePics;
}
- (NSArray *)hkbMainPagePics {
    if (!_hkbMainPagePics) {
        if ([_hkbMainPage isEqualToString:@""] || [_hkbMainPage isEqualToString:@"||"]) {
            _hkbMainPagePics = nil;
        }
        else
            {
            NSArray *imgs = [_hkbMainPage componentsSeparatedByString:@"||"];
            _hkbMainPagePics = imgs;
            }
    }
    return _hkbMainPagePics;
}
- (NSArray *)guarantor1IdNoPics {
    if (!_guarantor1IdNoPics) {
        if ([_guarantor1IdNo isEqualToString:@""] || [_guarantor1IdNo isEqualToString:@"||"]) {
            _guarantor1IdNoPics = nil;
        }
        else
            {
            NSArray *imgs = [_guarantor1IdNo componentsSeparatedByString:@"||"];
            _guarantor1IdNoPics = imgs;
            }
    }
    return _guarantor1IdNoPics;
}
- (NSArray *)guarantor1HkbPics {
    if (!_guarantor1IdNoPics) {
        if ([_guarantor1Hkb isEqualToString:@""] || [_guarantor1Hkb isEqualToString:@"||"]) {
            _guarantor1HkbPics = nil;
        }
        else
            {
            NSArray *imgs = [_guarantor1Hkb componentsSeparatedByString:@"||"];
            _guarantor1HkbPics = imgs;
            }
    }
    return _guarantor1HkbPics;
}
- (NSArray *)guarantor2IdNoPics {
    if (!_guarantor2IdNoPics) {
        if ([_guarantor2IdNo isEqualToString:@""] || [_guarantor2IdNo isEqualToString:@"||"]) {
            _guarantor2IdNoPics = nil;
        }
        else
            {
            NSArray *imgs = [_guarantor2IdNo componentsSeparatedByString:@"||"];
            _guarantor2IdNoPics = imgs;
            }
    }
    return _guarantor2IdNoPics;
}
- (NSArray *)guarantor2HkbPics {
    if (!_guarantor2HkbPics) {
        if ([_guarantor2Hkb isEqualToString:@""] || [_guarantor2Hkb isEqualToString:@"||"]) {
            _guarantor2HkbPics = nil;
        }
        else
            {
            NSArray *imgs = [_guarantor2Hkb componentsSeparatedByString:@"||"];
            _guarantor2HkbPics = imgs;
            }
    }
    return _guarantor2HkbPics;
}
- (NSArray *)ghIdNoPics {
    if (!_ghIdNoPics) {
        if ([_ghIdNo isEqualToString:@""] || [_ghIdNo isEqualToString:@"||"]) {
            _ghIdNoPics = nil;
        }
        else
            {
            NSArray *imgs = [_ghIdNo componentsSeparatedByString:@"||"];
            _ghIdNoPics = imgs;
            }
    }
    return _ghIdNoPics;
}
- (NSArray *)ghHkbPics {
    if (!_ghHkbPics) {
        if ([_ghHkb isEqualToString:@""] || [_ghHkb isEqualToString:@"||"]) {
            _ghHkbPics = nil;
        }
        else
            {
            NSArray *imgs = [_ghHkb componentsSeparatedByString:@"||"];
            _ghHkbPics = imgs;
            }
    }
    return _ghHkbPics;
}
- (NSArray *)housePicPics {
    if (!_housePicPics) {
        if ([_housePic isEqualToString:@""] || [_housePic isEqualToString:@"||"]) {
            _housePicPics = nil;
        }
        else
            {
            NSArray *imgs = [_housePic componentsSeparatedByString:@"||"];
            _housePicPics = imgs;
            }
    }
    return _housePicPics;
}
- (NSArray *)houseUnitPicPics {
    if (!_houseUnitPicPics) {
        if ([_houseUnitPic isEqualToString:@""] || [_houseUnitPic isEqualToString:@"||"]) {
            _houseUnitPicPics = nil;
        }
        else
            {
            _houseUnitPicPics = [_houseUnitPic componentsSeparatedByString:@"||"];
            }
    }
    return _houseUnitPicPics;
}
- (NSArray *)houseDoorPicPics {
    if (!_houseDoorPicPics) {
        if ([_houseDoorPic isEqualToString:@""] || [_houseDoorPic isEqualToString:@"||"]) {
            _houseDoorPicPics = nil;
        }
        else
            {
            NSArray *imgs = [_houseDoorPic componentsSeparatedByString:@"||"];
            _houseDoorPicPics = imgs;
            }
    }
    return _houseDoorPicPics;
}
- (NSArray *)houseRoomPicPics {
    if (!_houseRoomPicPics) {
        if ([_houseRoomPic isEqualToString:@""] || [_houseRoomPic isEqualToString:@"||"]) {
            _houseRoomPicPics = nil;
        }
        else
            {
            NSArray *imgs = [_houseRoomPic componentsSeparatedByString:@"||"];
            _houseRoomPicPics = imgs;
            }
    }
    return _houseRoomPicPics;
}
- (NSArray *)houseCustomerPicPics {
    if (!_houseCustomerPicPics) {
        if ([_houseCustomerPic isEqualToString:@""] || [_houseCustomerPic isEqualToString:@"||"]) {
            _houseCustomerPicPics = nil;
        }
        else
            {
            NSArray *imgs = [_houseCustomerPic componentsSeparatedByString:@"||"];
            _houseCustomerPicPics = imgs;
            }
    }
    return _houseCustomerPicPics;
}
- (NSArray *)houseSaleCustomerPicPics {
    if (!_houseSaleCustomerPicPics) {
        if ([_houseSaleCustomerPic isEqualToString:@""] || [_houseSaleCustomerPic isEqualToString:@"||"]) {
            _houseSaleCustomerPicPics = nil;
        }
        else
            {
        NSArray *imgs = [_houseSaleCustomerPic componentsSeparatedByString:@"||"];
        _houseSaleCustomerPicPics = imgs;
            }
    }
    return _houseSaleCustomerPicPics;
}
- (NSArray *)companyNamePicPics {
    if (!_companyNamePicPics) {
        if ([_companyNamePic isEqualToString:@""] || [_companyNamePic isEqualToString:@"||"]) {
            _companyNamePicPics = nil;
        }
        else
            {
            NSArray *imgs = [_companyNamePic componentsSeparatedByString:@"||"];
            _companyNamePicPics = imgs;
            }
    }
    return _companyNamePicPics;
}
- (NSArray *)companyPlacePicPics {
    if (!_companyPlacePicPics) {
        if ([_companyPlacePic isEqualToString:@""] || [_companyPlacePic isEqualToString:@"||"]) {
            _companyPlacePicPics = nil;
        }
        else
            {
            NSArray *imgs = [_companyPlacePic componentsSeparatedByString:@"||"];
            _companyPlacePicPics = imgs;
            }
    }
    return _companyPlacePicPics;
}
- (NSArray *)companyWorkshopPicPics {
    if (!_companyWorkshopPicPics) {
        if ([_companyWorkshopPic isEqualToString:@""] || [_companyWorkshopPic isEqualToString:@"||"]) {
            _companyWorkshopPicPics = nil;
        }
        else
            {
        NSArray *imgs = [_companyWorkshopPic componentsSeparatedByString:@"||"];
        _companyWorkshopPicPics = imgs;
            }
    }
    return _companyWorkshopPicPics;
}
- (NSArray *)companySaleCustomerPicPics {
    if (!_companySaleCustomerPicPics) {
        if ([_companySaleCustomerPic isEqualToString:@""] || [_companySaleCustomerPic isEqualToString:@"||"]) {
            _companySaleCustomerPicPics = nil;
        }
        else
            {
        NSArray *imgs = [_companySaleCustomerPic componentsSeparatedByString:@"||"];
        _companySaleCustomerPicPics = imgs;
            }
    }
    return _companySaleCustomerPicPics;
}
- (NSArray *)otherFilePdfPics {
    if (!_otherFilePdfPics) {
        if ([_otherFilePdf isEqualToString:@""] || [_otherFilePdf isEqualToString:@"||"]) {
            _otherFilePdfPics = nil;
        }
        else
            {
        NSArray *imgs = [_otherFilePdf componentsSeparatedByString:@"||"];
        _otherFilePdfPics = imgs;
            }
    }
    return _otherFilePdfPics;
}
@end
