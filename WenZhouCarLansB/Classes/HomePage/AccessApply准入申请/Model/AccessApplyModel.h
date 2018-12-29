//
//  AccessApplyModel.h
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessApplyModel : NSObject


//                    经销售请求

//结婚证
@property (nonatomic , copy)NSString *marryDivorce;
@property (nonatomic , strong)NSArray *marryDivorcePics;
//户口本
@property (nonatomic , copy)NSString *applyUserHkb;
@property (nonatomic , strong)NSArray *applyUserHkbPics;
//银行流水
@property (nonatomic , copy)NSString *bankBillPdf;
@property (nonatomic , strong)NSArray *bankBillPdfPics;
//单身证明
@property (nonatomic , copy)NSString *singleProvePdf;
@property (nonatomic , strong)NSArray *singleProvePdfPics;
//收入证明
@property (nonatomic , copy)NSString *incomeProvePdf;
@property (nonatomic , strong)NSArray *incomeProvePdfPics;
//居住证明
@property (nonatomic , copy)NSString *liveProvePdf;
@property (nonatomic , strong)NSArray *liveProvePdfPics;
//购房发票
@property (nonatomic , copy)NSString *houseInvoice;
@property (nonatomic , strong)NSArray *houseInvoicePics;
//自建房证明
@property (nonatomic , copy)NSString *buildProvePdf;
@property (nonatomic , strong)NSArray *buildProvePdfPics;
//户口本（首页）
@property (nonatomic , copy)NSString *hkbFirstPage;
@property (nonatomic , strong)NSArray *hkbFirstPagePics;
//户口本（户主页）
@property (nonatomic , copy)NSString *hkbMainPage;
@property (nonatomic , strong)NSArray *hkbMainPagePics;
//担保人1身份证
@property (nonatomic , copy)NSString *guarantor1IdNo;
@property (nonatomic , strong)NSArray *guarantor1IdNoPics;
//担保人1户口本
@property (nonatomic , copy)NSString *guarantor1Hkb;
@property (nonatomic , strong)NSArray *guarantor1HkbPics;
//担保人2身份证
@property (nonatomic , copy)NSString *guarantor2IdNo;
@property (nonatomic , strong)NSArray *guarantor2IdNoPics;
//担保人2户口本
@property (nonatomic , copy)NSString *guarantor2Hkb;
@property (nonatomic , strong)NSArray *guarantor2HkbPics;
//共还人身份证
@property (nonatomic , copy)NSString *ghIdNo;
@property (nonatomic , strong)NSArray *ghIdNoPics;
//共还人户口本
@property (nonatomic , copy)NSString *ghHkb;
@property (nonatomic , strong)NSArray *ghHkbPics;





//小区外观
@property (nonatomic , copy)NSString *housePic;
@property (nonatomic , strong)NSArray *housePicPics;
//单元楼照片
@property (nonatomic , copy)NSString *houseUnitPic;
@property (nonatomic , strong)NSArray *houseUnitPicPics;
//门牌照片
@property (nonatomic , copy)NSString *houseDoorPic;
@property (nonatomic , strong)NSArray *houseDoorPicPics;
//客厅照片
@property (nonatomic , copy)NSString *houseRoomPic;
@property (nonatomic , strong)NSArray *houseRoomPicPics;
//主贷与住宅合影
@property (nonatomic , copy)NSString *houseCustomerPic;
@property (nonatomic , strong)NSArray *houseCustomerPicPics;
//签约员与客户在房子合影照片
@property (nonatomic , copy)NSString *houseSaleCustomerPic;
@property (nonatomic , strong)NSArray *houseSaleCustomerPicPics;




//企业名称照片
@property (nonatomic , copy)NSString *companyNamePic;
@property (nonatomic , strong)NSArray *companyNamePicPics;
//办公场地照片
@property (nonatomic , copy)NSString *companyPlacePic;
@property (nonatomic , strong)NSArray *companyPlacePicPics;
//生产车间照片
@property (nonatomic , copy)NSString *companyWorkshopPic;
@property (nonatomic , strong)NSArray *companyWorkshopPicPics;
//签约员与客户在公司合影照片
@property (nonatomic , copy)NSString *companySaleCustomerPic;
@property (nonatomic , strong)NSArray *companySaleCustomerPicPics;



//其他材料附件
@property (nonatomic , copy)NSString *otherFilePdf;
@property (nonatomic , strong)NSArray *otherFilePdfPics;

//@property (nonatomic , copy)NSString *guarantor2Hkb;
//@property (nonatomic , strong)NSArray *guarantor2HkbPics;
//
//@property (nonatomic , copy)NSString *guarantor2Hkb;
//@property (nonatomic , strong)NSArray *guarantor2HkbPics;
//
//@property (nonatomic , copy)NSString *guarantor2Hkb;
//@property (nonatomic , strong)NSArray *guarantor2HkbPics;
//
//@property (nonatomic , copy)NSString *guarantor2Hkb;
//@property (nonatomic , strong)NSArray *guarantor2HkbPics;




//资产情况
@property (nonatomic , copy)NSString *isHouseProperty;
@property (nonatomic , copy)NSString *houseProperty;
@property (nonatomic , strong)NSArray *housePropertyPics;

@property (nonatomic , copy)NSString *isLicense;
@property (nonatomic , copy)NSString *license;
@property (nonatomic , strong)NSArray *licensePics;

@property (nonatomic , copy)NSString *isDriceLicense;
@property (nonatomic , copy)NSString *driceLicense;
@property (nonatomic , strong)NSArray *driceLicensePics;

@property (nonatomic , copy)NSString *isSiteProve;
@property (nonatomic , copy)NSString *siteProve;
@property (nonatomic , strong)NSArray *siteProvePics;

@property (nonatomic , copy)NSString *siteArea;
@property (nonatomic , copy)NSString *otherPropertyNote;

@property (nonatomic , copy)NSString *carType;
@property (nonatomic , copy)NSString *carTypeStr;

@property (nonatomic , strong)NSDictionary *bankSubbranch;

@property (nonatomic , copy)NSString *bocFeeWay;
@property (nonatomic , copy)NSString *oilSubsidy;
@property (nonatomic , copy)NSString *oilSubsidyKil;
@property (nonatomic , copy)NSString *gpsDeduct;
@property (nonatomic , copy)NSString *gpsFeeWay;
@property (nonatomic , copy)NSString *gpsFee;
@property (nonatomic , copy)NSString *isPlatInsure;

//其他情况
@property (nonatomic , copy)NSString *otherNote;
@property (nonatomic , copy)NSString *guarantor2BirthAddress;
@property (nonatomic , copy)NSString *guarantor1BirthAddress;
@property (nonatomic , copy)NSString *ghBirthAddress;
@property (nonatomic , copy)NSString *houseType;




@property (nonatomic , copy)NSString *applyNowAddress;
@property (nonatomic , copy)NSString *applyBirthAddress;


//紧急联系人
@property (nonatomic , copy)NSString *emergencyRelation2;
@property (nonatomic , copy)NSString *emergencyMobile2;
@property (nonatomic , copy)NSString *emergencyName2;
@property (nonatomic , copy)NSString *emergencyRelation1;
@property (nonatomic , copy)NSString *emergencyMobile1;
@property (nonatomic , copy)NSString *emergencyName1;


@property (nonatomic , copy)NSString *guarantor2JourShowIncome;
@property (nonatomic , copy)NSString *guarantor2Balance;
@property (nonatomic , copy)NSString *guarantor2SettleInterest;
@property (nonatomic , copy)NSString *guarantor2MonthIncome;
@property (nonatomic , copy)NSString *guarantor2IsPrint;

@property (nonatomic , copy)NSString *guarantor1JourShowIncome;
@property (nonatomic , copy)NSString *guarantor1Balance;
@property (nonatomic , copy)NSString *guarantor1SettleInterest;
@property (nonatomic , copy)NSString *guarantor1MonthIncome;
@property (nonatomic , copy)NSString *guarantor1IsPrint;
//guarantor1MonthIncome

@property (nonatomic , copy)NSString *ghJourShowIncome;
@property (nonatomic , copy)NSString *ghBalance;
@property (nonatomic , copy)NSString *ghSettleInterest;
@property (nonatomic , copy)NSString *ghMonthIncome;
@property (nonatomic , copy)NSString *ghIsPrint;

@property (nonatomic , copy)NSString *applyUserJourShowIncome;
@property (nonatomic , copy)NSString *applyUserBalance;
@property (nonatomic , copy)NSString *applyUserSettleInterest;
@property (nonatomic , copy)NSString *applyUserMonthIncome;
@property (nonatomic , copy)NSString *applyUserIsPrint;



//客户类型
@property (nonatomic , copy)NSString *customerType;
@property (nonatomic , copy)NSString *carDealerType;
@property (nonatomic , copy)NSString *marryState;
@property (nonatomic , copy)NSString *applyUserGhrRelation;
@property (nonatomic , copy)NSString *applyUserDuty;
@property (nonatomic , copy)NSString *applyUserCompany;
@property (nonatomic , copy)NSString *rateType;
@property (nonatomic , copy)NSString *carDealerSubsidy;
@property (nonatomic , copy)NSString *loanPeriods;
@property (nonatomic , copy)NSString *companyLoanCs;
@property (nonatomic , copy)NSString *globalRate;
@property (nonatomic , copy)NSString *bankLoanCs;
@property (nonatomic , copy)NSString *carDealerName;
@property (nonatomic , copy)NSString *frameNo;
@property (nonatomic , copy)NSString *bankRate;
@property (nonatomic , copy)NSString *originalPrice;
@property (nonatomic , copy)NSString *PreCompanyLoanCs;
@property (nonatomic , copy)NSString *invoicePrice;
@property (nonatomic , copy)NSString *budgetCode;
@property (nonatomic , copy)NSString *bizCompanyName;
@property (nonatomic , copy)NSString *collectionAccountNo;
@property (nonatomic , copy)NSString *userName;
@property (nonatomic , copy)NSString *isAdvanceFund;
@property (nonatomic , copy)NSString *monthIncome;
@property (nonatomic , copy)NSString *wxJourBalance;
@property (nonatomic , copy)NSString *carModel;
@property (nonatomic , copy)NSString *saleUserId;
@property (nonatomic , copy)NSString *guaCompanyName;
@property (nonatomic , copy)NSString *isCardMailAddress;

@property (nonatomic , copy)NSString *applyUserName;
@property (nonatomic , copy)NSString *carSettleDatetime;
@property (nonatomic , copy)NSString *mateWxJourInterest;
@property (nonatomic , copy)NSString *repayBankCode;
@property (nonatomic , copy)NSString *mateZfbJourExpend;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *guaZfbJourMonthIncome;
@property (nonatomic , copy)NSString *age;
@property (nonatomic , copy)NSString *companyCode;
@property (nonatomic , copy)NSString *guaInterest2;
@property (nonatomic , copy)NSString *teamName;
@property (nonatomic , copy)NSString *zfbJourInterest;
@property (nonatomic , copy)NSString *jourExpend;
@property (nonatomic , copy)NSString *mateMobile;
@property (nonatomic , copy)NSString *carFrameNo;
@property (nonatomic , copy)NSString *mateJourExpend;
@property (nonatomic , copy)NSString *mobile;
@property (nonatomic , copy)NSString *mateJourMonthExpend;
@property (nonatomic , copy)NSString *idKind;
@property (nonatomic , copy)NSString *mateInterest1;
@property (nonatomic , copy)NSString *mateJourIncome;
@property (nonatomic , copy)NSString *loanAmount;
//@property (nonatomic , copy)NSString *marryState;
@property (nonatomic , copy)NSString *guaCompanyAddress;
@property (nonatomic , copy)NSString *familyNumber;
@property (nonatomic , copy)NSString *mateZfbJourBalance;
@property (nonatomic , copy)NSString *guaZfbJourInterest;
@property (nonatomic , copy)NSString *wxJourIncome;
@property (nonatomic , copy)NSString *mateCompanyName;
@property (nonatomic , copy)NSString *repayBankName;
@property (nonatomic , copy)NSString *carSeries;
@property (nonatomic , copy)NSString *political;
@property (nonatomic , copy)NSString *invoiceCompany;
@property (nonatomic , copy)NSString *loanProductName;
@property (nonatomic , copy)NSString *loanBankName;
@property (nonatomic , copy)NSString *nowAddress;
@property (nonatomic , copy)NSString *cancelNodeCode;
@property (nonatomic , copy)NSString *saleUserName;
@property (nonatomic , copy)NSString *companyName;
@property (nonatomic , copy)NSString *customerName;

@property (nonatomic , copy)NSString *shopWay;
@property (nonatomic , copy)NSString *shopWayStr;

@property (nonatomic , copy)NSString *applyDatetime;
@property (nonatomic , copy)NSString *curNodeCode;

@property (nonatomic , strong)NSDictionary *credit;

@property (nonatomic , copy)NSString *carInvoice;
@property (nonatomic , copy)NSString *otherIncomeNote;
@property (nonatomic , copy)NSString *currentInvoicePrice;
@property (nonatomic , copy)NSString *carHgzPic;
@property (nonatomic , copy)NSString *carJqx;
@property (nonatomic , copy)NSString *carSyx;
@property (nonatomic , copy)NSString *interviewOtherPdf;
@property (nonatomic , strong)NSArray *pics1;
@property (nonatomic , strong)NSArray *pics2;
@property (nonatomic , strong)NSArray *pics3;
@property (nonatomic , strong)NSArray *pics4;
@property (nonatomic , strong)NSArray *pics5;

@property (nonatomic , copy)NSString *fee;

@property (nonatomic , copy)NSArray *budgetOrderGpsList;

@property (nonatomic , copy)NSString *carDealerCode;
@property (nonatomic , copy)NSString *carDealerCodeStr;
@property (nonatomic , copy)NSArray *carDealerArray;
@property (nonatomic , copy)NSString *loanBankCode;

@end
