
//+------------------------------------------------------------------+
//|                                                    PACTrader.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                            https://www.mql5.com/users/traorestan |
//+------------------------------------------------------------------+

#property strict

enum ENUM_OP_TYPE
  {
      OpBuy       = OP_BUY,         // Buy
      OpSell      = OP_SELL,        // Sell
      //OpBuyLimit  = OP_BUYLIMIT,    // Buy Limit
      //OpSellLimit = OP_SELLLIMIT,   // Sell Limit
      //OpBuyStop   = OP_BUYSTOP,     // Buy Stop
      //OpSellStop  = OP_SELLSTOP     // Sell Stop
      OpNo        = -1             // 
  };

enum ENUM_RISK_BY
  {
      RiskPercentage,     // Percentage
      RiskAmount          // Amount
  };
  
enum ENUM_SL_BY
  {
      SL_Price,           // Price
      SL_Points           // Points
  };
enum ENUM_TP_BY
  {
      TP_Percentage,      // Percentage
      TP_Amount,          // Amount
      TP_Price,           // Price
      TP_Points           // Points
  };
  
enum ENUM_TRADING_MODE {
     Normal_Tmode,           // Normal
     Aggressive_Tmode,      // Aggressive
};

enum ENUM_TRADING_STYLE {
     Trade_Style1,       // Martingal
     Trade_Style2,      // Double Martingal
     Trade_Style3      // Style 3
};

enum ENUM_AUTO_MAN_MODE {
   Automatic_Tmode,      // Automatic
   Manual_Tmode         // Manual
};

enum ENUM_MULTIPLIER_K {
   Mu_k0,      // 1.0
   Mu_k1,      // 1.1
   Mu_k2,      // 1.2
   Mu_k3,      // 1.3
   Mu_k4,      // 1.4
   Mu_k5,      // 1.5
   Mu_k6,      // 1.6
   Mu_k7,      // 1.7
   Mu_k8,      // 1.8
   Mu_k9,      // 1.9
   Mu_k10      // 2.0
};

enum ENUM_MONEY_MAN_PCR {   // Percent Money Management
   PCR_36,                 // 36%
   PCR_40,                // 40%
   PCR_50,               // 50%
   PCR_56,              // 56%
   PCR_60,             // 60%
   PCR_66,            // 66%
   PCR_70,           // 70%
   PCR_75,          // 75%
   PCR_80          // 80%
};

enum ENUM_PAY_FEE {
   Fee_Not_Pay,                 // Not pay Fee
   Fee_Pay_Com,                // Pay Commission
   Fee_Pay_Com_Swap           // Pay Commission and Swap
};


enum ENUM_MONEY_MAN_FRQ {        // Money Management Frequency
   Month_FRQ,                   // Monthly
   Week_FRQ,                   // Weekly
   Day2_FRQ,                  // 3 Days
   Day_FRQ,                  // Daily
   Aggresive_FRQ            // Aggressively
};

enum ENUM_TRADING_PERIOD {
   Month_TPeriod = 1,              // 1 Month
   Trimester_TPeriod = 3,         // Trimester
   Semester_TPeriod = 6,         // Semester
   Month9_TPeriod = 9,          // 9 Months
   Year1_TPeriod = 12,          // 1 Year
   Month15_TPeriod = 15,       // 15 Months
   Month18_TPeriod = 18,      // 18 Months
   Month21_TPeriod = 21,     // 21 Months
   Year2_TPeriod = 24      // 2 years
};


enum ENUM_START_IN_X_DAY {
   Start_Today,                      // Today
   Start_Tomorrow,                  // Tomorrow
   Start_Monday,                   // Monday
   Start_Tuesday,                 // Tuesday
   Start_Wednesday,              // Wednesday
   Start_Thurday,               // Thursday
   Start_Friday,               // Friday
   Start_Saturday,            // Saturday
   Start_Sunday              // Sunday 
};

enum ENUM_START_IN_AT_MODE {
   In_TMode,                 // In Mode
   At_TMode                 // At Mode
};

enum ENUM_START_AT_X_TIME {
   Start_NowH,                      // Now
   Start_at_0H,                    // 00H
   Start_at_1H,                   // 01H
   Start_at_2H,                  // 02H
   Start_at_3H,                 // 03H
   Start_at_6H,                // 06H
   Start_at_10H,              // 10H
   Start_at_12H,             // 12H
   Start_at_16H,            // 16H
   Start_at_20H,           // 20H
   Start_at_21H,          // 21H
   Start_at_22H,         // 22H
   Start_at_23H         // 23H
};

enum ENUM_START_IN_X_MINUTE {
   Start_Now,                  // Now
   Start_in_5Min,             // 5 Minute
   Start_in_10Min,           // 10 Minute
   Start_in_15Min,          // 15 Minute
   Start_in_30_Min         // 30 Minute
};

enum ENUM_PIVOT_CAPITAL {
   PVC_100,       // 100 %
   PVC_70,       // 75 %
   PVC_65,      // 65 % 
   PVC_60,     // 60 %
   PVC_55,    // 55 %
   PVC_50,   // 50 %
   PVC_40   // 40 %
};

 extern string _Basic_= "------------------------------------";    // BASIC SETTUP
 extern double LotInitial=0.01;                                   // Initial Volume
 extern ENUM_MULTIPLIER_K Mu_SELECT = Mu_k3;                     // Multiplier
        double Multiplier=0;                                  
 extern int TakeProfit=50;                                     // Take Profit
 extern int MaxPosNb=20;                                      // Maximum Orders Position
 extern const int Slippage=5;                                // Slippage
 extern const int MagicNumber=8888;                         // Magic Number
 
 
 extern string _Orders_= "------------------------------------";        // ORDERS SETTUP
 extern bool EnableVolatilityProtect=true;                          // Volatility Protection
 extern int EndBarProxSecond = 5;                                     // End Bar Proximity Second
 extern ENUM_TRADING_STYLE Trading_Style = Trade_Style1;            // Trading Style
 extern ENUM_TRADING_MODE Trading_Mode = Normal_Tmode;             // Trading Mode
 
        bool EnableReversalVolumeRise = true;                    // Enable Reversal Volume Rise
 extern bool EnableAutoMoneyManagement = true;                  // Auto Money Management
        bool AutoCompound = false;                             // AutoCompound
 extern ENUM_PIVOT_CAPITAL PivotCapitalPerCent_SLQ = PVC_100;            // Pivot Capital Percent
                    double PivotCapitalPerCent = 0;
 extern ENUM_MONEY_MAN_PCR CapitalRiskPercent = PCR_66;                // Capital Risk Percent
                           double PCR=0;
 extern ENUM_MONEY_MAN_FRQ AutoMoneyManFrequency = Aggresive_FRQ;    // Auto Money Management Frequency

 
 extern string _Profits_= "------------------------------------";        // PROFITS SETTUP
 extern bool AutoCorrectTp = true;                                      // Auto Correct Tp
 extern ENUM_PAY_FEE PayFee = Fee_Pay_Com;                             // Pay Fee
 extern bool EnableFloatingSpread = true;                             // Enable Floating Spread
 extern int FurtherFloatingPip = 3;                                  // Further Floating Pip
 extern int profitFactor = 9;                                       // Profit Factor
 
 
 extern string _TTime_= "------------------------------------";           // TRADING TIME SETTUP
 extern ENUM_DAY_OF_WEEK WeekDayTradeLimit = FRIDAY;                     // WeekDay Trade Limit
 extern ENUM_START_IN_AT_MODE StartTime_in_at_Mode = At_TMode;          // Start Time In/At Mode
 extern ENUM_START_IN_X_DAY StartDay_SLQ = Start_Today;                // Start Day
        int StartDay = 0;
 extern ENUM_START_AT_X_TIME StartTime_SLQ = Start_NowH;             // Start Time 
        int StartTime = 0;                                          // Start hour of Trading day
 extern ENUM_START_IN_X_MINUTE StartMinute_SLQ = Start_Now;        // Start in X Minute
        int StartMinute = 0;                                      //
 extern ENUM_TRADING_PERIOD TradePeriod = Semester_TPeriod;      // Trading Period
        int CloseDay = 30*TradePeriod;
        int CloseTime = 18;                                    // Final Day Close Time 
 extern bool UseLocalTimeInsteadOfFx = false;                 // Use Local Time Instead Of Forex


 extern string _Mis_= "------------------------------------";          // MISCELLEANEOUS
 extern string  OrdComment   = "PAC";                                 // Order Comment
 extern bool EnableNotifByEmail=true;                                // Enable Notification By Email
 extern bool EnablePushNotif=true;                                  // Enable Push Notification
 extern bool EnableMartingalCloseSound = true;                     // Enable Martingal Close Sound
 extern string MartingalCloseSound = "wait.wav";                  // Martingale Close Sound
 extern bool isTestMode = false;


 extern string _Config_= "------------------------------------";         // CONFIG
 extern bool UseBIR = false;                                            // Use BIR
 extern string BIR = "3L1.10.5";                                        // Base Investment Regime (BIR)
 extern string LicenseKey = "ARSD465T";                                // Lisense Key
 
 datetime LicenseExpiryDate;
 bool LicenseAutorised = false;
 
double IMultiplier=0;
double ILotInitial=LotInitial;
int IMaxPosNb=MaxPosNb;
 
bool isStartTradingTime = false;
bool isFinalTradingTime = false;
bool TradeAutorisation = false;
bool AlertStopTrade=false;
datetime TimeWhenInitialised;
datetime TrueFinalCloseTime;
datetime TrueBeginingTime;
int remainingDay=0;
int LastWeekDay=0;
bool StopTradeSellOrder=false;
bool StopTradeBuyOrder=false;
long MonthMaxRiskReached=0;
int MonthMaxPosReached=0;

double GBLSellTpPrice =0;
double GBLBuyTpPrice =0;


 int Ret=0;
 int errCode=0;
 
 bool Interrupt = false;
 bool RobotRun=true;

 bool PrintIt1Time=false;

 int ttt=0;
 int Sp=0;
 double Pi=0;
 int Pn, Pf;
 double lot,LastLot, RST, RPT, RGT, Rs, Rp;
 long CRmax=0;
 double loti, lotf;
 
 double savedLoti;
 double savedLotf;
 double savedRGT;
 
 int FirstOrderTicket=0;
 
 double SellLastPosLot=0;
 double SellLastPosPrice=0;
 double SellLastPosTp=0;
 int SellLastPosTicket=0;
 datetime SellLastPosBarTime=0;

 double SellNextPosLot=0;
 double SellNextPosTp=0;
 int SellNextOrderNb;
 
 double BuyNextPosLot=0;
 double BuyNextPosTp=0;
 int BuyNextOrderNb=0;

 int BuyLastPosTicket=0;
 double BuyLastPosLot=0;
 double BuyLastPosPrice=0;
 double BuyLastPosTp=0;
 datetime BuyLastPosBarTime=0;
 
 double FirstOrdOpenPrice=0;
 double LastOrdOpenPrice=0;
 double minLotInfo=0;
 double maxLotInfo=0;
 int pipInfo=0;
 
 bool accept;
 
 int v=0;
 int SellOrdersNb=0;
 int BuyOrdersNb=0;
 int ticket =0;
 
 long startBalance=0;

ENUM_OP_TYPE MartinigaleOrderTyp = OpNo;
ENUM_OP_TYPE ReversalOrderTyp = OpNo;

datetime LastAutoMoneyManagementTime;

int MinuteBar = 0;  // Bar Minute time
int CurrentMinuteBar = 0;
//////////////////////////////

string ErrMsg;
int errcode=0;
int CaptureErr=0;

bool NotifyReport1Time = true;
bool EA_ReadyToLaunch = false;

double _sl,_tp;
int cpt;
int pdt;

double Sl, Tp, TickVal, RISK, Vol, Profit;

double LastPositionSavedTp=0;

int NbTotalTrade=0;

//////////
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
      //Alert(AccountCompany());
      
      if(IsDemo()){ // Allow only Demo Account
         EA_ReadyToLaunch = true;
      }else{
         //Protect();
         LicenseVerifier();
         
         if(LicenseAutorised){
            EA_ReadyToLaunch = true;
         }else{
            EA_ReadyToLaunch = false;
         }
         
      }
   
      if(EA_ReadyToLaunch)
        {
            ChartSetSymbolPeriod(0, NULL, PERIOD_M5); // Setting Timeframe to M5
               
            Comment("PAC Trader Running...");
            
            //////////////////// Placing Button
            PlaceButton("interrupt", "Interrupt", 940, 15, 80, 25, Red, Red); //Interrupt Current Process
            ///////////////////
            
            /////////////////// Creating Rectangles
            CreateRectangleLabel("info-rect", 5, 50, 155, 145, clrNONE, Navy); // creating Rectangle
            CreateRectangleLabel("info-rectL", 5, 50, 55, 145, clrGray, Black); //Creating Left Rectangles
            //////////////////
       
            /////////////// Drawing Text
            WriteTxtLabel("account-info", "Account: ", 10, 55);
            WriteTxtLabel("equity-info", "Equity:    ", 10, 70);
            WriteTxtLabel("pos-info", "Positions:   ", 10, 85);
            WriteTxtLabel("mProfit-info", "B. Profit:   ", 10, 100);
            WriteTxtLabel("rProfit-info", "S. Profit:   ", 10, 115);
            WriteTxtLabel("minLot-info", "Min. Lot:   ", 10, 130);
            WriteTxtLabel("maxLot-info", "Max. Lot:   ", 10, 145);
            WriteTxtLabel("pip-info", "Distance:     ", 10, 160);
            WriteTxtLabel("crmax-info", "CRmax:     ", 10, 175);
            ///////////////
            
            // Multiplier Value
             switch(Mu_SELECT)
                 {
                  case Mu_k0 :
                    Multiplier = 1.0;
                    break;
                  case Mu_k1 :
                    Multiplier = 1.1;
                    break;
                  case Mu_k2 :
                    Multiplier = 1.2;
                    break;
                  case Mu_k3:
                     Multiplier = 1.3;
                     break;
                  case Mu_k4:
                     Multiplier = 1.4;
                     break;
                  case Mu_k5:
                     Multiplier = 1.5;
                     break;
                  case Mu_k6:
                     Multiplier = 1.6;
                     break;
                  case Mu_k7:
                     Multiplier = 1.7;
                     break;
                  case Mu_k8:
                     Multiplier = 1.8;
                     break;
                  case Mu_k9:
                     Multiplier = 1.9;
                     break;
                  case Mu_k10:
                     Multiplier = 2.0;
                     break;
                  default:
                     Multiplier= 1.0;
                    break;
                 }
            IMultiplier = Multiplier;  // saving Initial
            
            
            switch(CapitalRiskPercent)
              {
               case PCR_36 :
                 PCR= 0.36;
                 break;
               case PCR_40 :
                 PCR= 0.4;
                 break;
               case PCR_50:
                  PCR= 0.5;
                  break;
               case PCR_56:
                  PCR= 0.56;
                  break;
               case PCR_60:
                  PCR= 0.6;
                  break;
               case PCR_66:
                  PCR= 0.66;
                  break;
               case PCR_70:
                  PCR= 0.7;
                  break;
               case PCR_75:
                  PCR= 0.75;
                  break;
               case PCR_80:
                  PCR= 0.8;
                  break;
               default:
                  PCR= 1;
                 break;
              }
             
            
            // StartDay Value
             switch(StartDay_SLQ)
                {
                  case Start_Today :
                    StartDay = TimeDayOfWeek(GetCurrentTime());
                    break;
                  case Start_Tomorrow :
                    StartDay = TimeDayOfWeek(GetCurrentTime())+1;
                    if(StartDay > 7) StartDay = 1;
                    break;
                  case Start_Monday :
                     StartDay = MONDAY;
                     break;
                  case Start_Tuesday :
                    StartDay = TUESDAY;
                     break;
                  case Start_Wednesday :
                    StartDay = WEDNESDAY;
                     break;
                  case Start_Thurday :
                     StartDay = THURSDAY;
                     break;
                  case Start_Friday:
                     StartDay = FRIDAY;
                     break;
                  case Start_Saturday:
                     StartDay = SATURDAY;
                     break;
                  case Start_Sunday:
                     StartDay = SUNDAY;
                     break;
                  default:
                     StartDay = TimeDayOfWeek(GetCurrentTime());
                    break;
                }
            
             // StartTime Value
             switch(StartTime_SLQ)
                {
                  case Start_NowH:
                    StartTime = TimeHour(GetCurrentTime());
                    break;
                  case Start_at_0H:
                    StartTime = 0;
                    break;
                  case Start_at_1H:
                    StartTime = 1;
                    break;
                  case Start_at_2H:
                    StartTime = 2;
                    break;
                  case Start_at_3H:
                    StartTime = 3;
                    break;
                  case Start_at_6H:
                    StartTime = 6;
                    break;
                  case Start_at_10H:
                    StartTime = 10;
                    break;
                  case Start_at_12H:
                    StartTime = 12;
                    break;
                  case Start_at_16H:
                    StartTime = 16;
                    break;
                  case Start_at_20H:
                    StartTime = 20;
                    break;
                  case Start_at_21H:
                    StartTime = 21;
                    break;
                  case Start_at_22H:
                    StartTime = 22;
                    break;
                  case Start_at_23H:
                    StartTime = 23;
                    break;
                  default:
                    StartTime = TimeHour(GetCurrentTime());
                    break;
                }
            // Start Minute
            switch(StartMinute_SLQ)
                {
                  case Start_Now:
                    StartMinute = 0;
                    break;
                  case Start_in_5Min:
                    StartTime = 5;
                    break;
                  case Start_in_10Min:
                    StartTime = 10;
                    break;
                  case Start_in_15Min:
                    StartTime = 15;
                    break;
                  case Start_in_30_Min:
                    StartTime = 30;
                    break;
                  default:
                     StartTime = 0;
                    break;
                }
            
            
            switch(PivotCapitalPerCent_SLQ)
              {
               case  PVC_100:
                 PivotCapitalPerCent = 1;
                 break;
               case  PVC_70:
                 PivotCapitalPerCent = 0.7;
                 break;
               case  PVC_65:
                 PivotCapitalPerCent = 0.65;
                 break;
               case  PVC_60:
                 PivotCapitalPerCent = 0.6;
                 break;
               case  PVC_55:
                 PivotCapitalPerCent = 0.55;
                 break;
               case  PVC_50:
                 PivotCapitalPerCent = 0.5;
                 break;
               case  PVC_40:
                 PivotCapitalPerCent = 0.4;
                 break;
               default:
                 break;
              }
            
            ///////////// AT INIT
            startBalance = GetBalance();
            //CloseDay = 5;
            
            MonthMaxRiskReached = 0;
            
            remainingDay = CloseDay;
            TimeWhenInitialised = GetCurrentTime();
            LastAutoMoneyManagementTime = TimeWhenInitialised;  // let's forbid auto money management when starting First Time
            /////////////
            
            //////////// Verification
            if(EndBarProxSecond > 59 ){EndBarProxSecond=59;}
            
            if(profitFactor > 15 ){ profitFactor=15;}
            ///////////
            
            //--- create timer
              EventSetTimer(3600);   // timer is executed each 1 Hour
            //---
            
            ////////--- create timer
             //EventSetTimer(10);   // timer is executed each 5 Minute
            ///////---
            
            return(INIT_SUCCEEDED);
            
        }else{
            return (INIT_FAILED);
        }
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   //--- destroy timer
   EventKillTimer();
  }
  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {   
      if(!isStartTradingTime){         // Programing First Trading Time
         VerifStartTradingTime();
      }else if(!isFinalTradingTime){
         VerifFinalTradingTime();
      }
      
      if(TradeAutorisation){
         PACTrader();
      }
  }
  
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {

      ttt++;
   
      // a Process Made every 3 Hours
      //if(!(ttt==3)) return;
      //else{ttt=0;}
            
   
      if(EnableAutoMoneyManagement  && AutoMoneyManFrequency != Aggresive_FRQ){
         
         if(AutoMoneyManFrequency == Day_FRQ)
         {
             if( (GetWeekday() <= WeekDayTradeLimit) && 
                  (TimeDayOfYear(GetCurrentTime()) != TimeDayOfYear(LastAutoMoneyManagementTime)) )
               {  //just for first time Or Every Day
                  LotCalculus();
                  LastAutoMoneyManagementTime = GetCurrentTime();
               }
         }
         else if(AutoMoneyManFrequency == Day2_FRQ)
         {
            if( (GetWeekday() <= WeekDayTradeLimit) &&
                  (TimeDayOfYear(GetCurrentTime()) != TimeDayOfYear(LastAutoMoneyManagementTime)+1) )
               {  //We Make exception of the next day
                  LotCalculus();
                  LastAutoMoneyManagementTime = GetCurrentTime();
               }
         }
         else if(AutoMoneyManFrequency == Week_FRQ)
         {
            if( (GetWeekday() <= WeekDayTradeLimit) &&
                (TimeDayOfYear(GetCurrentTime()) >= TimeDayOfYear(LastAutoMoneyManagementTime)+WeekDayTradeLimit) )
            {
               LotCalculus();
               LastAutoMoneyManagementTime = GetCurrentTime();
            }
         }
         else if(AutoMoneyManFrequency == Month_FRQ)
         {
            if( (GetWeekday() <= WeekDayTradeLimit) &&
                (TimeMonth(GetCurrentTime()) != TimeMonth(LastAutoMoneyManagementTime)) )
            {
               LotCalculus();
               LastAutoMoneyManagementTime = GetCurrentTime();
            }
         }  
      }
      
      // Remaining Day system
      if( (GetWeekday() != LastWeekDay)  && (remainingDay >= 0) )
      {  //just for first time Or Every Day
         
         remainingDay--;
         LastWeekDay = GetWeekday();
      } 
  }
  
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,const long &lparam, const double &dparam, const string &sparam)
  {
//---
  }
//+------------------------------------------------------------------+


void PACTrader()
{
   // Verify if Trade Allowed
   if(!IsTradeAllowed()){
      RobotRun=false;
      Alert("Autotrade is NOT allowed.");
      return;
   }else {RobotRun=true;}
   

   // Verify if Interuption is called
   if(Interrupt && RobotRun==true && OrdersTotal()==0){  // Interrupt only when all orders closed
      RobotRun=false;   // Set Robot Off
  
      if(PrintIt1Time) {
         Print("Robot Interrupted...");
         PrintIt1Time=false;
         MessageBox("System going to close all Orders...until further notice",NULL,MB_OK);
       }
    }else {PrintIt1Time=true;}


   ///////////////////////////////////////////////////////////////////////// TRADE WHEN ROBOT ALLOWED
   if(RobotRun)
   {
   
      GetNbOfPosition(OpSell);
      GetNbOfPosition(OpBuy);
      
      /////////// Verify if existing Last Orders
      if( BuyOrdersNb ==0  && SellOrdersNb == 0){  // when not existing Orders
      
         //Final Trading Close
         if(AlertStopTrade){
            RobotRun=false;
            TradeAutorisation = false;
            TrueFinalCloseTime = GetCurrentTime();
            FinalNotificator();
            return;
         }
         
         // Monthly Notification
         if(isMonthReached()){
            if(NotifyReport1Time){
               Print("MONTH REACHED...");
               MonthlyNotificator();
               
               MonthMaxPosReached=0;
               MonthMaxRiskReached=0;
            }
         }
       }
       
       ///////////////////////////////////////// MONEY MANAGEMENT
         if(EnableAutoMoneyManagement)
         {
            if(AutoMoneyManFrequency == Aggresive_FRQ)
            {
               if( GetWeekday() <= WeekDayTradeLimit ){
                  
                   if(Trading_Style == Trade_Style1){
    
                        if(BuyOrdersNb ==0 && SellOrdersNb == 0){
                           LotCalculus();
                           LastAutoMoneyManagementTime = GetCurrentTime();
                        }
                  
                    }else if(Trading_Style == Trade_Style2){
                        
                        if(BuyOrdersNb ==0 || SellOrdersNb == 0){
                           LotCalculus();
                           LastAutoMoneyManagementTime = GetCurrentTime();
                        }
                        
                    }
               }
            }
         }
      //////////////////////////////////////////
      
      
      
      
      ////////////////////////////////////////////  CLOSE ORDER SOUND
      if(Trading_Style == Trade_Style1){
      
         if(EnableMartingalCloseSound){ // Play Sound When Martingale Closed
            if( SellOrdersNb==0 && BuyOrdersNb == 0 )
               {PlaySound(MartingalCloseSound);}
         }
      }
      else if(Trading_Style == Trade_Style2){
      
         if(EnableMartingalCloseSound){ // Play Sound When Martingale Closed
            if( (SellOrdersNb==0 && BuyOrdersNb > 0) || (SellOrdersNb > 0  && BuyOrdersNb == 0) )
               {PlaySound(MartingalCloseSound);}
         }
      }
      ////////////////////////////////////////////
      
      
      ////////////////////////////////////////////  FIRST POSITION TRADE
      
      if(Trading_Style == Trade_Style2){
         if(SellOrdersNb==0){
            if(EnableAutoMoneyManagement)ApplyMoneyManagementChange();
            
            if(!StopTradeSellOrder)
                {TradeNow(OpSell);}
         }
         
         if(BuyOrdersNb==0){
            if(EnableAutoMoneyManagement)ApplyMoneyManagementChange();
            
            if(!StopTradeBuyOrder)
                {TradeNow(OpBuy);}       
         }
      
      }else if(Trading_Style == Trade_Style1){
      
            if(SellOrdersNb ==0 && BuyOrdersNb == 0){
            
               if(EnableAutoMoneyManagement)ApplyMoneyManagementChange();
               
               if(!StopTradeSellOrder)
                {TradeNow(OpSell);}
            
               if(!StopTradeBuyOrder)
                {TradeNow(OpBuy);}   
            }
      
      }
      ///////////////////////////////////////////
      
      
      //////////////////////////////////////////  AUTO CORRECT GLOBAL TP
      if(AutoCorrectTp){
          CorrectAllTp(OpBuy);
          CorrectAllTp(OpSell);
      }
      /////////////////////////////////////////
      
      
      ///////////////////////////////////////////   TRADING ACCORDING TO TRADE STYLE
      GetNbOfPosition(OpSell);
      GetNbOfPosition(OpBuy);
      
      if( BuyOrdersNb > 0 || SellOrdersNb > 0 ){
      
         ///////////// Display Stats
            DisplayStat();
         ////////////
         
         if(Trading_Style == Trade_Style1){  /////////////////// TRADING STYLE 1
            
            if(SellOrdersNb > 0){
               if(!StopTradeSellOrder)
                  {TryTrade(OpSell);}
            }
            
            if(BuyOrdersNb > 0){
               if(!StopTradeBuyOrder)
                  {TryTrade(OpBuy);}
            }
         }
         else if(Trading_Style == Trade_Style2)  //////////////  TRADING STYLE 2
         {
         
            if(AlertStopTrade){
            
                GetNbOfPosition(OpSell);
                GetNbOfPosition(OpBuy);
               
                if(SellOrdersNb==0){
                   StopTradeSellOrder = true;
                   Print("STOP TRADE SELL ORDERS...");
                }
                
                if(BuyOrdersNb==0){
                   StopTradeBuyOrder = true;
                   Print("STOP TRADE BUY ORDERS...");
                }
            }
         
            if(!StopTradeSellOrder)
               {TryTrade(OpSell);}
            
            if(!StopTradeBuyOrder)
               {TryTrade(OpBuy);}
         }
         //////////////////////////////////////////
         
         
         
         //////////////
         // Saving Max Month Risk Reached
         if( GetCurrentRisk() < MonthMaxRiskReached){
            MonthMaxRiskReached = GetCurrentRisk();
            
            if(MonthMaxRiskReached >= getCRmax()){
               Print("MONTH MAX RISK REACHED NOW: ", MonthMaxRiskReached);
            }
         }
         
         // Saving Max Month Pos Reached
         if(SellOrdersNb > MonthMaxPosReached){
            MonthMaxPosReached = SellOrdersNb;
            Print("MONTH MAX POSITION REACHED NOW: ", MonthMaxPosReached);
         }else if(BuyOrdersNb > MonthMaxPosReached){
            MonthMaxPosReached = BuyOrdersNb;
            Print("MONTH MAX POSITION REACHED NOW: ", MonthMaxPosReached);
         }
         /////////////
      }
      
      //////////////////////////////////////////////////////////////////////////////////////////
   }
}


void ApplyMoneyManagementChange()
 {
    if(LotInitial < ILotInitial){
        Print("MONEY MANAGEMENT CHANGED LOT INITIAL FROM: ", LotInitial, " TO: ", ILotInitial);
        LotInitial = ILotInitial;
    }
    if(MaxPosNb < IMaxPosNb){
        Print("MONEY MANAGEMENT CHANGED MAXPOS FROM: ", MaxPosNb, " TO: ", IMaxPosNb);
        MaxPosNb = IMaxPosNb;
    }
    if(Multiplier < IMultiplier){
        Print("MONEY MANAGEMENT CHANGED MULTIPLIER FROM: ", Multiplier, " TO: ", IMultiplier);
        Multiplier = IMultiplier;
    }
    
 }

void TryTrade(ENUM_OP_TYPE OrdTyp)
{
      SelectLastOrder(OrdTyp);

      if(OrdTyp == OpSell)
         {if(!OrderSelect(SellLastPosTicket, SELECT_BY_TICKET)) return;}
      else if(OrdTyp == OpBuy)
         {if(!OrderSelect(BuyLastPosTicket, SELECT_BY_TICKET)) return;}
      
      
      if(EnableVolatilityProtect){
          MinuteBar = TimeMinute(Time[0]);  // Bar Minute time
          CurrentMinuteBar = TimeMinute(TimeCurrent()); // 
         
          if( MathAbs(CurrentMinuteBar - MinuteBar) <= 0){  //when maximum 1 minute reached
               if(TimeSeconds(TimeCurrent()) <= EndBarProxSecond )
                  {TradeAgain(OrdTyp);}
           }
      }else
         {TradeAgain(OrdTyp);}

}


void TradeAgain(ENUM_OP_TYPE OrdTyp)
{
      SelectLastOrder(OrdTyp);
         
      if(OrdTyp == OpSell){
         if( Bid >= NormalizeDouble(SellLastPosPrice + (TakeProfit*Point), Digits) )
            {TradeNow(OpSell);}
         
      }else if(OrdTyp == OpBuy){
         if( Ask <= NormalizeDouble(BuyLastPosPrice - (TakeProfit*Point), Digits) )
            {TradeNow(OpBuy);}
      }
}


void TradeNow(ENUM_OP_TYPE OrdTyp)
{
      
      if(OrdTyp == OpSell){
         // Calculate NextPosLot
         SellNextPosLot=CalcLoti(OpSell);
         // Place Position
         PlacePosition(SellNextPosLot, Bid, 0, 0, OpSell);
      }else if(OrdTyp == OpBuy){
         // Calculate NextPosLot
         BuyNextPosLot=CalcLoti(OpBuy);
         // Place Position
         PlacePosition(BuyNextPosLot, Ask, 0, 0, OpBuy);
      }
      
      ///////// Modify Long Trade All Take Profit
       ModifyLongTradeAllTP(OrdTyp);
      /////////
}


void ModifyLongTradeAllTP(ENUM_OP_TYPE OrdTyp)
 {
       /////////////calculate global tp price
       
      GetNbOfPosition(OrdTyp);
      
      if(OrdTyp == OpSell && SellOrdersNb >= 1){
         GBLSellTpPrice = CalcGlobalTpPrice(OpSell);
      
         if(ModifyAllTp(OpSell, GBLSellTpPrice, 0))
            {Print(getWhatOrderIs(OrdTyp), " ", SellOrdersNb, " POSITION(S) GLOBAL TP MODIFIED AND SET TO: ", GBLSellTpPrice);}
      }
      
      if(OrdTyp == OpBuy && BuyOrdersNb >= 1){
         GBLBuyTpPrice = CalcGlobalTpPrice(OpBuy);
      
         if(ModifyAllTp(OpBuy, GBLBuyTpPrice, 0))
            {Print(getWhatOrderIs(OrdTyp), " ", BuyOrdersNb, " POSITION(S) GLOBAL TP MODIFIED AND SET TO: ", GBLBuyTpPrice);}
      }
 }



bool ModifyAllTp(ENUM_OP_TYPE OrdTyp, double tp, double sl)
 {    
      bool m=true;
      
      for(int i=OrdersTotal(); i>=0; i--)
      {
         if(OrderSelect(i,SELECT_BY_POS)){
            
            if(OrderSymbol()==Symbol() && OrderType()==OrdTyp && OrderMagicNumber()==MagicNumber){
               
               if(tp<0) tp=OrderTakeProfit();  // tp cannot be negative
               
               if(OrdTyp == OpSell){
                  if(tp>Ask) tp=OrderTakeProfit();
                  if(sl<Ask) sl=OrderStopLoss();
               }
               else if(OrdTyp==OpBuy){
                  if(tp<Bid) tp=OrderTakeProfit();
                  if(sl>Bid) sl=OrderStopLoss();
               }
               
               if(!OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,0,clrPurple)){
                  Print("OrderModify Error: ",ErrorDescription(GetLastError()));
                  m = false;
               }

            }
         }
      }
         
      return m;
 }


void CorrectAllTp(ENUM_OP_TYPE OrdTyp)
 {    
 
      double tp=0, sl=0;
 
      for(int i=OrdersTotal(); i>=0; i--)
      {                                                                                                                                                                                                                                                                                                                                                                 
         if(OrderSelect(i,SELECT_BY_POS)){
            
            if(OrderSymbol()==Symbol() && OrderType()==OrdTyp && OrderMagicNumber()==MagicNumber){
               tp=OrderTakeProfit();
               
               if(OrdTyp == OpSell){
                  if((OrderTakeProfit() > GBLSellTpPrice) || (OrderTakeProfit() < GBLSellTpPrice ))
                     { if(GBLSellTpPrice > 0){tp=GBLSellTpPrice;} }
               }else if(OrdTyp == OpBuy){
                  if((OrderTakeProfit() > GBLBuyTpPrice) || (OrderTakeProfit() < GBLBuyTpPrice))
                     { if(GBLBuyTpPrice > 0){tp=GBLBuyTpPrice;} }
               }
               
               if( (tp > OrderTakeProfit() ) || ( tp < OrderTakeProfit()) ){
                  if(OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,0,clrPurple))
                     {Print(getWhatOrderIs(OrdTyp),", ORDER: ", OrderTicket(), " TP CORRECTED TO: ", OrderTakeProfit());}
               }
            }
         }
      }
       
 }

void VerifStartTradingTime()
 {
   
   if( TimeDayOfWeek(GetCurrentTime()) == StartDay){
         
         if(StartTime_in_at_Mode == At_TMode){
            if(TimeHour(GetCurrentTime()) >= StartTime ){
               if( TimeMinute(GetCurrentTime()) >= StartMinute){
                  isStartTradingTime = true;
                  TradeAutorisation = true;
                  TrueBeginingTime = GetCurrentTime();
                  Print("TRADE TIME AUTORISED...");
               }
             }
         }
         else if(StartTime_in_at_Mode == In_TMode){
            if( TimeHour(GetCurrentTime()) >= (TimeHour(TimeWhenInitialised)+StartTime) ){
               if( TimeMinute(GetCurrentTime()) >= (TimeMinute(TimeWhenInitialised)+StartMinute )  ){
                  isStartTradingTime = true;
                  TradeAutorisation = true;
                  TrueBeginingTime = GetCurrentTime();
                  Print("TRADE TIME AUTORISED...");
               }
             }
         }
    }
 }
 
void VerifFinalTradingTime()
 {
    if(remainingDay <= 0){
      if( TimeHour(GetCurrentTime()) >= (TimeHour(TrueBeginingTime)) ){
         if( TimeMinute(GetCurrentTime()) >= (TimeMinute(TrueBeginingTime)) ){
            isFinalTradingTime = true;
            AlertStopTrade = true;
            Print("STOP TRADE ALERTED...");
         }
       }
    }
 }


int CalcReachedDay()
{
   return (CloseDay - remainingDay);
}


bool isMonthReached()
{
   bool is=false;
   
   if( (CalcReachedDay()%30) == 0 && remainingDay != CloseDay ){
      
      if( TimeHour(GetCurrentTime()) >= (TimeHour(TrueBeginingTime)) ){
         if( TimeMinute(GetCurrentTime()) >= (TimeMinute(TrueBeginingTime)) ){
            is =true;
            Print("STOP TRADE ALERTED...");
         }
       }
      
   }else {
      if(NotifyReport1Time != true){NotifyReport1Time=true;}
      is = false;
   }
   
   return is;
}


void MonthlyNotificator()
 {
      ///////////// Send Report when it's right time during trading days
        string msg = OrdComment + " Trade Report: " +
                     "\nMonth Date: " + (string) GetCurrentTime() +
                     "\nStarting Date: " + (string) TrueBeginingTime +
                     "\nTraded Days: " + (string) CalcReachedDay() + " / " + (string) CloseDay +
                     "\nRemaining Days: " + (string) remainingDay +
                     "\nBalance: " + (string) AccountBalance() +
                     "\nEquity: " + (string) AccountEquity() +
                     "\nTotal Trade Request: "+ (string) NbTotalTrade ;
         
        Notificator(msg);
        Print("MONTHLY NOTIFICATION PERFORMED...");
      ///////////////
 }
 
 
void FinalNotificator()
 {
      ///////////// Send Report when it's right time during trading days
      string msg = OrdComment + " Trade Report: " +
                     "\nFinal Date: " + (string) TrueFinalCloseTime +
                     "\nStarting Date: " + (string) TrueBeginingTime +
                     "\nTraded Day: " + (string) CalcReachedDay() + " / " + (string) CloseDay +
                     "\nRemaining Day: " + (string) remainingDay +
                     "\nBalance: " + (string) AccountBalance() +
                     "\nEquity: " + (string) AccountEquity() +
                     "\nTotal Trade Request: "+ (string) NbTotalTrade ;

      Notificator(msg);
      Print("FINAL NOTIFICATION PERFORMED...");
      ///////////////
 }


void Notificator(string msg)
 {
      ///////////// Send Report when it's right time during trading days
         if(EnablePushNotif) {
            if(SendNotification(msg))
               { Print("Push Notification Report Sent...please verify");}
         }
         
         if(EnableNotifByEmail){
             if(SendMail(OrdComment + " Trade Report: - "+ AccountCompany()+ " - " + AccountServer() + " - " +
               (string)AccountNumber() + " - "+ AccountName(),msg)){
                  Print("E-mail Report Sent...please verify");
             }
         }
         
         NotifyReport1Time=false;
      ///////////////
 }

bool VerifyExistingOrder(int Ticket)
 {
    bool isIt=false;
   
    if(OrderSelect(Ticket, SELECT_BY_TICKET))
      {isIt = true;}
 
     return isIt;
 }


double CalcGlobalTpPrice(ENUM_OP_TYPE OrdTyp)
 {
      double globaltp=0;
      int profitPip=0;
      int Nbpos=0;
      
      GetNbOfPosition(OrdTyp);
      
      if(OrdTyp == OpSell)
         {Nbpos =  SellOrdersNb;}
      else if(OrdTyp == OpBuy)
         {Nbpos = BuyOrdersNb;}
      
      
      if(Nbpos>1){
      
         double lot1=0;
   
         // Calculate Profit for Position 1
         SelectFirstOrder(OrdTyp);
         
         if(OrderSelect(FirstOrderTicket,SELECT_BY_TICKET))
            {lot1=OrderLots();}
         
         // Calculate Profit Pip
         profitPip = ClosePipComputing(lot1, Nbpos, OrdTyp);
         
         if(EnableFloatingSpread){
            int Fp = (int) SymbolInfoInteger(Symbol(), SYMBOL_SPREAD_FLOAT);
            
            if(Fp > 5){ Fp = 5;}
            
            profitPip += Fp; 
         }
         
         profitPip += FurtherFloatingPip;
         
         ///// EA UBAT PROFIT CALC MODE
         
         if(Nbpos>=3){
            int d=0;
            
            d = Nbpos - 3;
            
            profitPip += profitFactor*(d+1);
         }else{
            profitPip += 5;
         }
         
         if( Multiplier >= 1.4 ){
            profitPip += Nbpos+3;
         }else if(Multiplier < 1.2){
            if(Nbpos>20)profitPip += Nbpos*5;
         }
         /////
         
      }else if(Nbpos==1)
         {profitPip = TakeProfit;}
      
      
      Print(getWhatOrderIs(OrdTyp), " PROFIT CLOSE PIP CALCULATED: ", profitPip);  
      
      // Calculate Tp global Price
      SelectLastOrder(OrdTyp);
      
      if(OrdTyp==OpSell)
         {globaltp = NormalizeDouble(SellLastPosPrice - (profitPip*Point), Digits);}
      else if(OrdTyp==OpBuy)
         {globaltp = NormalizeDouble(BuyLastPosPrice + (profitPip*Point), Digits);}
      
     
      //Print(getWhatOrderIs(OrdTyp), " GLOBAL TP MODIFIED AND SET TO: ", globaltp);
   
      // Calculate Tp global Price
      return globaltp;
 }
 

////////////////////////////////////
/// \brief TPnProfitPip
/// \param n
/// \return
///

int TPnProfitPip(double pftToreach, ENUM_OP_TYPE OrdTyp)
{
    double Profit2Reach=0;
    double profitPip=0;

    // Calculate Profit to Reach
    Profit2Reach = pftToreach;
    
    SelectLastOrder(OrdTyp);

    if(OrdTyp==OpSell)
      profitPip = ceil((Profit2Reach/SellLastPosLot));
    else if(OrdTyp == OpBuy)
      profitPip = ceil((Profit2Reach/BuyLastPosLot));

    // Calculate Tp global Price
    return (int) profitPip;

}


double MartinigaleGblProfit(int gblTpPip, ENUM_OP_TYPE OrdTyp)
 {
      double profit=0;
      double gblTpPrice=0;
      int NbPos=0;
      
      SelectLastOrder(OrdTyp);

      for(int i=0; i <= OrdersTotal(); i++){

          if(OrderSelect(i, SELECT_BY_POS)){
          
             if(OrdTyp==OpBuy){  // Buy Order Type
                if(OrderType() == OrdTyp && OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber){
                   gblTpPrice = NormalizeDouble(BuyLastPosPrice + (gblTpPip*Point), Digits);
                   
                   profit += OrderLots() * ( (gblTpPrice - OrderOpenPrice()) / Point);
               }
             }else if(OrdTyp==OpSell){
                if(OrderType() == OrdTyp && OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber){
                   gblTpPrice = NormalizeDouble(SellLastPosPrice - (gblTpPip*Point), Digits);
                   
                   profit += OrderLots() * ( (OrderOpenPrice() - gblTpPrice) / Point);
                }
             }
             
             GetNbOfPosition(OrdTyp);
             
             if(OrdTyp == OpSell) NbPos = SellOrdersNb;
             else if(OrdTyp == OpBuy) NbPos = BuyOrdersNb;
             
             if(NbPos > 2)
                 { profit -= OrderLots() * (SymbolInfoInteger(Symbol(), SYMBOL_SPREAD) ); }
             
             if(PayFee == Fee_Pay_Com || PayFee == Fee_Pay_Com_Swap) profit += OrderCommission();
             
             if(PayFee == Fee_Pay_Com_Swap) profit += OrderSwap();
             
          }
     }

      return profit;
 }



/////////////////////////////
/// \brief ClosePipComputing
/// \param lot1
/// \param n
/// \return            ***
///
int ClosePipComputing(double lot1, int n, ENUM_OP_TYPE OrdTyp)  // Relative TpPrice computing
 {
    double Profit2Reach=0;
    bool GoWithoutFear=true;
    int q=20;

    int svdTpPip=0;
    double svdProfit=0;

    int gblTpPip=0;
    double gblProfit=0;

    Profit2Reach = lot1*TakeProfit*n;
    gblTpPip = ( TPnProfitPip(Profit2Reach, OrdTyp) / 2);

    while (GoWithoutFear){

        gblProfit = NormalizeDouble(MartinigaleGblProfit(gblTpPip, OrdTyp), 2); // relative profit
        
        if( gblProfit < Profit2Reach){
            /////////Saved good Result
            svdProfit = gblProfit;
            svdTpPip = gblTpPip;

            gblTpPip = IncrementorTpPip(gblTpPip, q);

        }else{
            if(!(q==1)){  // When pip change of 1 let's ajust value to the nearest great profit
               ////////// Retake Good Result
               gblProfit = svdProfit;
               gblTpPip = svdTpPip;
            }

            q /=2;

           if(q < 1) {GoWithoutFear=false;}
        }
     }
     
     //Print(getWhatOrderIs(OrdTyp), " GBL PROFIT FINAL: ", gblProfit);

    return gblTpPip;

 }

///////////////////////////////////////
/// \brief IncrementorTpPip
/// \param tpPip
/// \param k
/// \return
///
int IncrementorTpPip(int tpPip, int k)
 {
    tpPip+=k;
    return tpPip;
 }


void SelectFirstOrder(ENUM_OP_TYPE MartinigaleOrdTyp)
   {  
      /////////////// Select First Orders
      double lotx = GetSymbolMaxVolume();
      
      ticket = OrdersTotal();
      
      for(int i=ticket; i >= 0; i--){  // execute until find First Orders
         if(OrderSelect(i, SELECT_BY_POS))
         {
            if(OrderSymbol() == Symbol() && OrderType()==MartinigaleOrdTyp && OrderMagicNumber() == MagicNumber){
               if(OrderLots() <= lotx ){
                  lotx = OrderLots();
                  FirstOrderTicket = OrderTicket();
               }
            }
         }
      }
   }

void SelectLastOrder(ENUM_OP_TYPE OrdTyp)
   {  
      /////////////// Select last Orders
      double lotx = GetSymbolMinVolume();;
      
      ticket = OrdersTotal();
      
      if(OrdTyp == OpSell){
         for(int i=0; i <= ticket; i++){  // execute 2 times
            if(OrderSelect(i, SELECT_BY_POS)){
               if(OrderSymbol() == Symbol() && OrderType() == OpSell && OrderMagicNumber() == MagicNumber){
                  if(OrderLots() >= lotx ){
                     lotx = OrderLots();
                     
                     SellLastPosPrice = OrderOpenPrice();
                     SellLastPosLot = OrderLots();
                     SellLastPosTp = OrderTakeProfit();
                     SellLastPosTicket = OrderTicket();
                     SellLastPosBarTime = OrderOpenTime();
                  }
               }
            }
         }
      }else if(OrdTyp == OpBuy){
          for(int i=0; i <= ticket; i++){  // execute 2 times
            if(OrderSelect(i, SELECT_BY_POS)){
               if(OrderSymbol() == Symbol() && OrderType() == OpBuy && OrderMagicNumber() == MagicNumber){
                  if(OrderLots() >= lotx ){
                     lotx = OrderLots();
                     
                     BuyLastPosPrice = OrderOpenPrice();
                     BuyLastPosLot= OrderLots();
                     BuyLastPosTp=OrderTakeProfit();
                     BuyLastPosBarTime=OrderOpenTime();
                     BuyLastPosTicket = OrderTicket();
                  }
               }
            }
         }
      }
   }


//+------------------------------------------------------------------+
//| function Calculate-Lot-for-Pos i    ***                          |
//+------------------------------------------------------------------+
double CalcLoti(ENUM_OP_TYPE OrdTyp)
  {
       double Lot=0;
       LastLot =0;
       
       SelectLastOrder(OrdTyp);
       GetNbOfPosition(OrdTyp);
       
        // Recover number of positions existing
         if(OrdTyp==OpSell){
            if(SellOrdersNb==0){
               LastLot = 0;
            }else {
               LastLot = SellLastPosLot;
            }
         }else if(OrdTyp==OpBuy){
            if(BuyOrdersNb==0){
               LastLot = 0;
            }else {
               LastLot = BuyLastPosLot;
            }
         }
         
        
        if(LastLot > 0){
            Lot=LastLot*Multiplier;            // Multiplicateur successif
        }else{
            LastLot = LotInitial;
            Lot=LastLot;
        }
        
        //Print("Lot initial: ", LotInitial);
        //Print("Lot: ", Lot);
        //Print("Mu: ", Multiplier);
        
        if(!CanRepeatLot(OrdTyp)){
            Lot=ceil(Lot*100)/100;    // if it's denieded to repeat we make ceil
            
            //Print(getWhatOrderIs(OrdTyp), " new Order Lot Repeated to: ", Lot);
        }else{
            Lot=round(Lot*100)/100;    // else we make usually round
            
            //Print(getWhatOrderIs(OrdTyp), " new Order Lot Changed to: ", Lot);
        }
        
         //Print("Lot after round: ", Lot);
         
        /*
        if(EnableReversalVolumeRise){
            GetOrderType();
           if(OrdTyp == ReversalOrderTyp){
               // verify Martinigal Orders Number
               if(MartinigaleOrderTyp == OpSell){
                  GetNbOfPosition(OpSell);
                  
                  if(SellOrdersNb >= 3 && BuyOrdersNb == 0){
                     //Recover The Second Sell Orders Volume
                     if(OrderSelect(1, SELECT_BY_POS) && OrderType()==MartinigaleOrderTyp){ // Recover the Second Order By Position 
                        Lot = OrderLots();  // let's set Volume to the second Orders
                     }
                  }
               } else if(MartinigaleOrderTyp == OpBuy){
                  GetNbOfPosition(OpBuy);
                  
                  if(BuyOrdersNb >= 3 && SellOrdersNb == 0 ){
                     //Recover The Second Sell Orders Volume
                     if(OrderSelect(1, SELECT_BY_POS) && OrderType()==MartinigaleOrderTyp){ // Recover the Second Order By Position 
                        Lot = OrderLots();  // let's set Volume to the second Orders
                     }
                  }
               }
           }
        }
       */
       
       /*
       if(OrdTyp == OpSell){
            if(SellOrdersNb==1){
               SelectFirstOrder(OrdTyp);
               if(OrderSelect(FirstOrderTicket, SELECT_BY_TICKET)){
                  Lot = OrderLots();
                  Print(getWhatOrderIs(OrdTyp), " 2nd ORDERS LOT MAINTAINED");
                }
            } 
       }else if(OrdTyp == OpBuy){
            if(BuyOrdersNb==1){
               SelectFirstOrder(OrdTyp);
               if(OrderSelect(FirstOrderTicket, SELECT_BY_TICKET)){
                  Lot = OrderLots();
                  Print(getWhatOrderIs(OrdTyp), " 2nd ORDERS LOT MAINTAINED TO: ", Lot);
                }
            } 
       }
      */
       
       //Print(getWhatOrderIs(OrdTyp)," Order, Lot Calculated and Set to: ", Lot);
       
       Lot = ControlVolume(Lot);  // volume Cannot exceed maxLot or under minLot
       
       return Lot;
  }
  


string getWhatOrderIs(ENUM_OP_TYPE OrdTyp)
{
    string ord="";
    
    if(OrdTyp == OpSell){
      ord = "SELL";
    }else if(OrdTyp == OpBuy){
      ord = "BUY";
    }else if(OrdTyp == OpNo){
      ord = "OPNO";
    }
    
    return ord;
}


bool CanRepeatLot(ENUM_OP_TYPE OrdTyp)
{
   bool r=false;
   int nbPos=0;
   
   GetNbOfPosition(OrdTyp);
   
   if(OrdTyp==OpSell){
      nbPos = SellOrdersNb;
   }else if(OrdTyp==OpBuy){
      nbPos = BuyOrdersNb;
   }
   
   if(nbPos == 0 || nbPos == 1){
      r = true;
   }else if(nbPos >= 2){
   
      r = (!HaveSuccessiveLot(OrdTyp));
   }
   
   return r;
}


bool HaveSuccessiveLot(ENUM_OP_TYPE OrdTyp){
      bool yes=true;
      
      // get Successive Lot
      double lot1;
      double lot2;
      
      double Lot[2]={0};
      int x=0;
      
      for(int i=0; i <= OrdersTotal(); i++){
         if(OrderSelect(i, SELECT_BY_POS)){
            if(OrderType() == OrdTyp && OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber){
               Lot[x] = OrderLots();
               
               if(x==0)
                  x=1;
               else if(x==1)
                  x=0;
            }
         }
      }
      
      lot1 = Lot[0];
      lot2 = Lot[1];
      
      if(lot1 < lot2 || lot1 > lot2) {
         yes = false;
      }
      
      return yes;
}


double MartinigaleProfit(ENUM_OP_TYPE OrdTyp)
 {
      double profit=0;
      
      for(int i=0; i <= OrdersTotal(); i++)
        {
            if(OrderSelect(i, SELECT_BY_POS)){
               if(OrderType() == OrdTyp && OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber)
               {
                  if(OrdTyp==OpSell){
                      profit += OrderLots() * ( NormalizeDouble(OrderOpenPrice() - OrderTakeProfit(), Digits) / Point );
                  }else if(OrdTyp==OpBuy){
                      profit += OrderLots() * ( NormalizeDouble(OrderTakeProfit() - OrderOpenPrice(), Digits) / Point );
                  }
               }
            }
        }
   
      return NormalizeDouble(profit, 2);
 }

void GetOrderType()
 {
      GetNbOfPosition(OpSell);
      GetNbOfPosition(OpBuy);
      
      if(SellOrdersNb > BuyOrdersNb) {
         MartinigaleOrderTyp = OpSell;
         ReversalOrderTyp = OpBuy;
      } else if (BuyOrdersNb > SellOrdersNb){
         MartinigaleOrderTyp = OpBuy;
         ReversalOrderTyp = OpSell;
      }  else if (BuyOrdersNb == SellOrdersNb){
         MartinigaleOrderTyp = OpNo;
         ReversalOrderTyp = OpNo;
      }
 }

void DisplayStat()
 {
      getInfo();
      
      ObjectSetText("account-info", "Account:    "+ IntegerToString( GetBalance() ) +" "+ AccountCurrency(), 8, NULL, White);
      ObjectSetText("equity-info", "Equity:        " + IntegerToString( GetEquity() ) +" "+ AccountCurrency(), 8,NULL, White);
      
      if(OrdersTotal() !=0){
      
         GetNbOfPosition(OpBuy);
         GetNbOfPosition(OpSell);
         
         ObjectSetText("pos-info", "Positions:    " + IntegerToString(SellOrdersNb+BuyOrdersNb), 8,NULL, White);
         ObjectSetText("mProfit-info", "B. Profit:     " + DoubleToString(MartinigaleProfit(OpBuy), 2), 8, NULL, White);
         ObjectSetText("rProfit-info", "S. Profit:     " + DoubleToString(MartinigaleProfit(OpSell), 2), 8, NULL, White);
         ObjectSetText("minLot-info", "Min. Lot:     " + DoubleToString(minLotInfo, 2), 8, NULL, White);
         ObjectSetText("maxLot-info", "Max. Lot:    " + DoubleToString(maxLotInfo, 2), 8, NULL, White);
         ObjectSetText("pip-info", "Distance :   " + IntegerToString(pipInfo), 8, NULL, White);
         ObjectSetText("crmax-info", "Risk max :   " +  IntegerToString(GetCurrentRisk())  + " / -" + IntegerToString(getCRmax()), 8, NULL, White);
      }
      
      RefreshRates();
 }


long GetCurrentRisk(){
   return (long) ( GetEquity() - GetBalance());
}

long GetBalance(){
   return (long)MathFloor(AccountBalance());
}

long GetEquity(){
   return (long)MathFloor(AccountEquity());
}

void getInfo()
{
     GetOrderType();
     SelectFirstOrder(MartinigaleOrderTyp);
     
     if(OrderSelect(FirstOrderTicket, SELECT_BY_TICKET) ){
         FirstOrdOpenPrice=OrderOpenPrice();
         minLotInfo = OrderLots();
     }
     
     SelectLastOrder(MartinigaleOrderTyp);
     if(MartinigaleOrderTyp==OpSell){
         LastOrdOpenPrice = SellLastPosPrice;
         maxLotInfo = SellLastPosLot;
     }else if(MartinigaleOrderTyp==OpBuy){
         LastOrdOpenPrice = BuyLastPosPrice;
         maxLotInfo = BuyLastPosLot;
     }
     
     pipInfo = (int) MathAbs( (FirstOrdOpenPrice-LastOrdOpenPrice)/Point );

}

//+------------------------------------------------------------------+
//| function Calc Risk global ***                                    |
//+------------------------------------------------------------------+
void CalcRiskGlobal(double Lot)
  {

   //Recalculating values
    Sp = (int) NormalizeDouble(Ask-Bid,0);  // Spread Value
   
    accept=true;

    Pn=0;
    Rs=Lot*Sp;
    RST=Rs;

    Pf = (TakeProfit*MaxPosNb)-TakeProfit;

    Rp=Lot*(Pf-Pn);
    RPT=Rp;
    
    for (v = 1; v < MaxPosNb; v++) {
        Pn+=TakeProfit;
        Pi+=TakeProfit;

        Lot*=Multiplier;            // Multiplicateur successif

        if(accept == false) {
            Lot=ceil(lot*100)/100;    // if it's denieded to repeat we make ceil
        } else {
            Lot=round(lot*100)/100;    // else we make usually round
        }

        if( Lot > LastLot) {
            accept=true;            // one accept to repeat
        } else {
            Lot= LastLot;
            accept = false;        //one denied to repeat
        }


        LastLot = Lot;        // lot de la boucle précédente

        Rs=Lot*Sp;            // Multiplicateur successif
        RST+=Rs;         // sommateur successif (Risk Spread Total)

        Rp=Lot*(Pf-Pn);     // Multiplicateur successif
        RPT+=Rp;        // sommateur successif (Risk Position Total)
   
    }
    
  }
 
 
 
 void PlacePosition(double Lot, double Price, double SL, double TP, ENUM_OP_TYPE OrdTyp)
   {
      errcode = 0;
      Ret = 0;
      int nbPos=0;
      
      GetNbOfPosition(OrdTyp);
      
      if(OrdTyp == OpSell){
        nbPos = SellOrdersNb;
      }else if(OrdTyp == OpBuy){
        nbPos = BuyOrdersNb;
      }

      if( nbPos <= MaxPosNb) // if market not closed, not have enough money, Not Invalid Stop and max pos nb not reached
        {
            if(OrdTyp==OpBuy || OrdTyp==OpSell) {
               Ret = OrderSend(Symbol(), OrdTyp, Lot, Price, Slippage, SL, TP, CommentThat(), MagicNumber, 0, clrNONE);
            }
            
            errcode = GetLastError();
            
            LastPositionSavedTp = TP;  // the last position executed take profit
      
            if(Ret == -1) {
                  Alert(getWhatOrderIs(OrdTyp)," Trade error: ", ErrorDescription(errcode));
                  return;
            }else {
                NbTotalTrade++;
                Print( getWhatOrderIs(OrdTyp)," New Position Successful Placed!");
            }
        }else{
            Print( getWhatOrderIs(OrdTyp), " Max Positions Reached, can't Trade!!!");
        }
   }



void GetNbOfPosition(ENUM_OP_TYPE OrdTyp)
 {
      if(OrdTyp==OpSell){ // Recover numbers of Sell position
         SellOrdersNb=0;
         
         for(int cnt=0; cnt<=OrdersTotal(); cnt++)
           {
               if(OrderSelect(cnt,SELECT_BY_POS)){
                  if(OrderSymbol() == Symbol() &&  OrderMagicNumber()==MagicNumber && OrderType()==OrdTyp)
                    {SellOrdersNb++;}
                }
           }
         
      }else if(OrdTyp==OpBuy) { // Recover numbers of Buy position
          BuyOrdersNb=0;
    
          for(int cnt=0; cnt<=OrdersTotal(); cnt++)
           {
               if(OrderSelect(cnt,SELECT_BY_POS)){
                  if(OrderSymbol() == Symbol() && OrderMagicNumber()==MagicNumber && OrderType()==OrdTyp)
                    {BuyOrdersNb++;}
                }
           }
      }  
 } 

//+----------------------------------------------------------------------------------------+
//|     CommentThat function                                                               |
//+----------------------------------------------------------------------------------------+
string CommentThat()
   {
      return OrdComment +" "+ IntegerToString(NbTotalTrade);
   }
//+----------------------------------------------------------------------------------------+


//+-------------------------------------------------------------------------------------+
//| GetSymbolMinVolume(), GetSymbolMaxVolume() functions                               |
//+------------------------------------------------------------------------------------+

 double GetSymbolMinVolume()
   {return SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);}

 double GetSymbolMaxVolume()
   {return SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);}
//+------------------------------------------------------------------------------------+



//+-------------------------------------------------------------------------------------+
//| Current GetMinute(), GetHour(), GetWeekday(), GetCurrentTime() functions            |
//+-------------------------------------------------------------------------------------+
 int GetMinute() {return TimeMinute(GetCurrentTime());}
 int GetHour(){return TimeHour(GetCurrentTime());}
 int GetWeekday(){return TimeDayOfWeek(GetCurrentTime());}

 datetime GetCurrentTime()
  {
     if(UseLocalTimeInsteadOfFx)
         {return TimeLocal();}
     else
        {return TimeCurrent();} // Recovering Current Forex Time
  }
  
//+------------------------------------------------------------------+
//|     Calculate Volume function                                    |
//+------------------------------------------------------------------+
double ControlVolume(double Lot)
  {

// volume regulation
   if(Lot < GetSymbolMinVolume()){ //--- Minimal allowed volume for trade operations
      Lot = GetSymbolMinVolume();
      Print(StringConcatenate("Volume less than the minimum allowed. The minimum volume is assigned : ", GetSymbolMinVolume(), "."));
   }
   else if(Lot > GetSymbolMaxVolume()){//--- Maximal allowed volume of trade operations
         Lot = GetSymbolMaxVolume();
         Print(StringConcatenate("Volume greater than the maximum allowed. The maximum volume is assigned : ", GetSymbolMaxVolume(), "."));
   }

   return Lot;
  }

//+------------------------------------------------------------------+
//|  Protect function                                                |
//+------------------------------------------------------------------+
void LicenseVerifier()
  {
      if(LicenseKey == "ARSD465T"){
         LicenseExpiryDate = StringToTime("2021.06.15 00:00");
         
         if( GetCurrentTime() > LicenseExpiryDate){
            LicenseAutorised = False;
            Alert("LICENSE EXPIRED! GO TO BUY A LICENSE KEY...");
            Print("LICENSE EXPIRED! GO TO BUY A LICENSE KEY...");
         }
         else{
            LicenseAutorised = True;
         }
         
      }else{
         LicenseAutorised = False;
         Alert("INVALIDE LICENSE KEY! GO TO BUY A LICENSE KEY...");
         Print("INVALIDE LICENSE KEY! GO TO BUY A LICENSE KEY...");
      }
  }
  
  
//+------------------------------------------------------------------+
//|  Protect function                                                |
//+------------------------------------------------------------------+
void Protect()
  { 
  
   //Recover Account Info
      long AcLogin = AccountInfoInteger(ACCOUNT_LOGIN);
      string AcCompany = AccountInfoString(ACCOUNT_COMPANY);
   
   //Allowed Brokers and Account
      const string allowed_broker[] = {"TW Corp.", "FBS Inc"};
      const long demo_allowed_accounts[] = {1140591,1201420};
      const long real_allowed_accounts[] = {514599, 471451, 473422, 487977, 487750, 473424, 300794630};
   
   //Checking License Key as Login Exist
      for(int i=0; i<ArraySize(allowed_broker); i++)
        {
            if(StringCompare(AcCompany, allowed_broker[i])==0){
               EA_ReadyToLaunch = true;
            }
        }
        
        
      if(!EA_ReadyToLaunch) {
         MessageBox("EA Broker Not Vérified...", NULL,MB_OK | MB_ICONSTOP);
         return;
      }
      else{EA_ReadyToLaunch=false;}
        
        
      for(int i=0; i<ArraySize(demo_allowed_accounts); i++)
        {
            if(AcLogin == demo_allowed_accounts[i]){
               EA_ReadyToLaunch = true;
               Print("EA Demo account verified...");
               break;
             } 
        }

      for(int i=0; i < ArraySize(real_allowed_accounts); i++)
        {
            if(AcLogin == real_allowed_accounts[i]){
               EA_ReadyToLaunch = true;
               Print("EA Real account verified...");
               break;
             }
        }
        
   
      if(!EA_ReadyToLaunch) {MessageBox("EA Account Not Vérified...", NULL,MB_OK | MB_ICONSTOP);}
      
  }
  
long getCRmax()
 {
      long cr=0;
      
      cr = (long) ( AccountBalance() * PivotCapitalPerCent * PCR);
      
      return cr;
 }


//+------------------------------------------------------------------+
//|  LotCalculus function    ***                                               |
//+------------------------------------------------------------------+
void LotCalculus() {

    long k=0;
    bool goo=true;
    long C=0;
    double Lot=0;
    
    LastLot=0;
    CRmax=0;
    RGT=0;
    RST=0;
    RPT=0;
    lotf=0;
    loti=0;
    
    
    C = (long) (AccountBalance() * PivotCapitalPerCent);
    
    Print("C: ", C);

    if( (C >= 100000000000000000) && (C < 1000000000000000000))          // 1000 T - 10000 T
        {k=100000000000000000;}
    else if( (C >= 10000000000000000) && (C < 100000000000000000))     // 100 T - 1000 T
        {k=10000000000000000;}
    else if( (C >= 1000000000000000) && (C < 10000000000000000))     // 1 T - 100 T
        {k=1000000000000000;}
    else if( (C >= 100000000000000) && (C < 1000000000000000))     // 100 B - 1 T
        {k=100000000000000;}
    else if( (C >= 10000000000000) && (C < 100000000000000))     // 10 B - 100 B
        {k=10000000000000;}
    else if( (C >= 1000000000000) && (C < 10000000000000))     // 1 B - 10 B
        {k=1000000000000;}
    else if( (C >= 100000000000) && (C < 1000000000000))     // 100 M9 - 1 B
        {k=100000000000;}
    else if( (C >= 10000000000) && (C < 100000000000))     // 10 M9 - 100 M9
        {k=10000000000;}
    else if( (C >= 1000000000) && (C < 10000000000))      // 1 M9 - 10 M9
        {k=1000000000;}
    else if ( (C >= 100000000) && (C < 1000000000))     // 100 M6 - 1 M9
        {k=100000000;}
    else if ( (C >= 10000000) && (C < 100000000))     // 10 M6 - 100 M6
        {k=10000000;}
    else if( (C >= 1000000) && (C < 10000000))      // 1 M6 - 10 M6
        {k=1000000;}
    else if ( (C >= 100000) && (C < 1000000))     // 100 M - 1M6
        {k=100000;}
    else if ( (C >= 10000) && (C < 100000))     // 10 M - 100 M
        {k=10000;}
    else if ( (C >= 1000) && (C < 10000))     // 1 M - 10 M
        {k=1000;}
    else {                                 // - 1 M
         Alert("Error: BAD Balance!!!");
         return;
    }

    loti = (double) ( (C*PCR)/1000000);   //Use for huge balance
    loti = (double) floor(loti*100)/100;
    
    if(loti < 0.01)
      {loti = 0.01;}


    ///////////////////////////
    Pf= (TakeProfit*MaxPosNb);   //Values can be higher not under; tested GBPGPY 2-4 Jan 2020
    
    if(Multiplier <= 1.3 ){
         Pf += TakeProfit + (int) (TakeProfit * 0.75);
    }else {
      Pf += (int) (TakeProfit*0.62);
    }
    ///////////////////////////
    
    CRmax = (long)(C*PCR);

    initSavedResult();
    
    Sp = (int) SymbolInfoInteger(Symbol(), SYMBOL_SPREAD);


   while(goo) {

       accept=true;
       Pn=0;
       Pi=10000;
       Lot=loti;
       LastLot=loti;

       Rs=Lot*Sp;
       
       RST=Rs;

       Rp=Lot*(Pf-Pn);
       RPT=Rp;


       for (v = 0; v <= MaxPosNb; v++) {  // Cannot be under
           Pn+=TakeProfit;
           Pi+=TakeProfit;
   
           if(v>0) Lot*=Multiplier;            // Multiplicateur successif
   
           if(accept == false) {
               Lot=ceil(Lot*100)/100;    // if it's denieded to repeat we make ceil
           } else {
               Lot=round(Lot*100)/100;    // else we make usually round
           }
           
           Lot = NormalizeDouble(Lot, 2);
   
           if( Lot > LastLot) {
               accept=true;            // one accept to repeat
           } else {
               Lot= LastLot;
               accept = false;        //one denied to repeat
           }
   
   
           LastLot = Lot;        // lot de la boucle précédente
   
           Rs=Lot*Sp;            // Multiplicateur successif
           RST+=Rs;         // sommateur successif (Risk Spread Total)
   
           Rp=Lot*(Pf-Pn);     // Multiplicateur successif
           RPT+=Rp;        // sommateur successif (Risk Position Total)
      
           RGT=RST+RPT;
        }


        if( RGT < CRmax){
            saveGoodResult(loti, LastLot, RGT);
            loti = incrementor(loti, k);
        }else{
            retakeGoodResult();

            k /= 10;

            if(k < 1000) {goo=false;}
        }
    }
    
    Print("RISK MAX: ", RGT, " / ", CRmax);
    
    if( (loti >= GetSymbolMinVolume()) && (lotf <= GetSymbolMaxVolume()) ){
      if( (loti > LotInitial) && (lotf > loti) ){
          ILotInitial = loti;   // Let's Change Initial Lot
          Print("LOT INITIAL CHANGED FROM: "+ (string) LotInitial +" TO "+ (string) ILotInitial +
                ", LOT FINAL WILL MATCH TO: "+ (string) lotf);
      }else{
          Print("LOT INITIAL CALCULATED AND MAINTAINED TO: "+ (string) LotInitial);
      }
    }else {
         Print("LOT INITIAL CALCULATED BUT NOT CHANGED BECAUSE OUT OF RANGE: "+ (string) GetSymbolMinVolume() +" - "+
         (string) GetSymbolMaxVolume()+ ", LOTi:"+ (string) loti +" LOTf:"+ (string) lotf);
         
    }
    
}

void initSavedResult()
{
    savedLoti=0;
    savedLotf=0;
    savedRGT=0;
}

void saveGoodResult(double lot1, double lotF, double rgt)
 {
    savedLoti=NormalizeDouble(lot1, 2);
    savedLotf=NormalizeDouble(lotF, 2);
    savedRGT=rgt;
 }

void retakeGoodResult()
 {
    loti=savedLoti;
    lotf=savedLotf;
    RGT=savedRGT;
 }


double incrementor(double lotx, double k)
 {
    double lt=0;

    k = 100000/k;  //increment step

    lt= lotx*k;
    lt++;
    lotx= lt/k;

    return NormalizeDouble(lotx, 2);
 }

double MuDecrementor()
 {
    double lt=0;

    lt = Multiplier*10;
    lt--;
    lt= lt/10;

    return lt;
 }

double PosIncrementor()
 {
    int lt=MaxPosNb;

    lt++;

    return lt;
 }
  
void PlaceButton(string objName, string btnText="btn", int xDist=0, int yDist=0, int xSize=0, int ySize=0,
      color BGColor = clrBlue, color BorderColor=clrBlue, color btnColor=clrWhite, int btnFontSize=12,
      bool propHide=true, bool btnState=false  ){
      
   ObjectCreate(0,objName,OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,objName,OBJPROP_XDISTANCE, xDist);
   ObjectSetInteger(0,objName,OBJPROP_YDISTANCE, yDist);
   ObjectSetInteger(0,objName,OBJPROP_XSIZE, xSize);
   ObjectSetInteger(0,objName,OBJPROP_YSIZE, ySize);
   
   ObjectSetString(0,objName,OBJPROP_TEXT, btnText);
   ObjectSetInteger(0,objName,OBJPROP_COLOR, btnColor);
   ObjectSetInteger(0,objName,OBJPROP_BGCOLOR, BGColor);
   ObjectSetInteger(0,objName,OBJPROP_BORDER_COLOR,BorderColor);
   ObjectSetInteger(0,objName,OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0,objName,OBJPROP_HIDDEN, propHide);
   ObjectSetInteger(0,objName,OBJPROP_STATE, btnState);
   ObjectSetInteger(0,objName,OBJPROP_FONTSIZE, btnFontSize);
}


void CreateRectangleLabel(string objName, int xDist=0, int yDist=0, int xSize=10, int ySize=10, color ObjColor=clrNONE,
         color BGColor=clrNONE, color BorderColor=clrNONE,int Corner=0, bool PropHide=true, bool Selectable=false){
   ObjectCreate(0,objName,OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSetInteger(0,objName,OBJPROP_XDISTANCE,xDist);
   ObjectSetInteger(0,objName,OBJPROP_YDISTANCE,yDist);
   ObjectSetInteger(0,objName,OBJPROP_XSIZE,xSize);
   ObjectSetInteger(0,objName,OBJPROP_YSIZE,ySize);
   ObjectSetInteger(0,objName,OBJPROP_CORNER,Corner);

   ObjectSetInteger(0,objName,OBJPROP_COLOR, ObjColor);
   ObjectSetInteger(0,objName,OBJPROP_BGCOLOR, BGColor);
   ObjectSetInteger(0,objName,OBJPROP_BORDER_COLOR,BorderColor);
   ObjectSetInteger(0,objName,OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0,objName,OBJPROP_HIDDEN,PropHide);
   ObjectSet(objName,OBJPROP_SELECTABLE,Selectable);
}


void WriteTxtLabel(string txtName, string txt="text", int xDist=0, int yDist=0, color txtColor=clrWhite, 
         int txtSize=8, int objCorner=0, bool propHide=true,bool selectable=false ){
   ObjectCreate(txtName, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(txtName, txt, txtSize,NULL, txtColor);
   ObjectSet(txtName, OBJPROP_CORNER, objCorner);
   ObjectSetInteger(0,txtName,OBJPROP_XDISTANCE,xDist);
   ObjectSetInteger(0,txtName,OBJPROP_YDISTANCE,yDist);
   ObjectSet(txtName,OBJPROP_HIDDEN,propHide);
   ObjectSet(txtName,OBJPROP_SELECTABLE,selectable);
}


void PlaceLine(string objName, double setAt, color LineColor=clrNavy, int LineWidth=6){
    ObjectCreate(objName,OBJ_HLINE, 0, Time[0],  setAt);
    ObjectSet(objName, OBJPROP_STYLE, STYLE_SOLID);
    ObjectSet(objName, OBJPROP_COLOR, LineColor);
    ObjectSet(objName, OBJPROP_WIDTH, LineWidth);
 }
 


 //+-----------------------------------------------------------------------------------------------------------------+
//| Error description function                                                                                      |
//+-----------------------------------------------------------------------------------------------------------------+
string ErrorDescription(int ErrorCode)
  {
   //--- Local variable
   string ErrorMsg;

   switch(ErrorCode)
     {
      //--- Codes returned from trade server
      case 0:    ErrorMsg="No error returned.";                                             break;
      case 1:    ErrorMsg="No error returned, but the result is unknown.";                  break;
      case 2:    ErrorMsg="Common error.";                                                  break;
      case 3:    ErrorMsg="Invalid trade parameters.";                                      break;
      case 4:    ErrorMsg="Trade server is busy.";                                          break;
      case 5:    ErrorMsg="Old version of the client terminal.";                            break;
      case 6:    ErrorMsg="No connection with trade server.";                               break;
      case 7:    ErrorMsg="Not enough rights.";                                             break;
      case 8:    ErrorMsg="Too frequent requests.";                                         break;
      case 9:    ErrorMsg="Malfunctional trade operation.";                                 break;
      case 64:   ErrorMsg="Account disabled.";                                              break;
      case 65:   ErrorMsg="Invalid account.";                                               break;
      case 128:  ErrorMsg="Trade timeout.";                                                 break;
      case 129:  ErrorMsg="Invalid price.";                                                 break;
      case 130:  ErrorMsg="Invalid stops.";                                                 break;
      case 131:  ErrorMsg="Invalid trade volume.";                                          break;
      case 132:  ErrorMsg="Market is closed.";                                              break;
      case 133:  ErrorMsg="Trade is disabled.";                                             break;
      case 134:  ErrorMsg="Not enough money.";                                              break;
      case 135:  ErrorMsg="Price changed.";                                                 break;
      case 136:  ErrorMsg="Off quotes.";                                                    break;
      case 137:  ErrorMsg="Broker is busy.";                                                break;
      case 138:  ErrorMsg="Requote.";                                                       break;
      case 139:  ErrorMsg="Order is locked.";                                               break;
      case 140:  ErrorMsg="Buy orders only allowed.";                                       break;
      case 141:  ErrorMsg="Too many requests.";                                             break;
      case 145:  ErrorMsg="Modification denied because order is too close to market.";      break;
      case 146:  ErrorMsg="Trade context is busy.";                                         break;
      case 147:  ErrorMsg="Expirations are denied by broker.";                              break;
      case 148:  ErrorMsg="The amount of open and pending orders has reached the limit.";   break;
      case 149:  ErrorMsg="An attempt to open an order opposite when hedging is disabled."; break;
      case 150:  ErrorMsg="An attempt to close an order contravening the FIFO rule.";       break;
      //--- Mql4 errors
      case 4000: ErrorMsg="No error returned.";                                             break;
      case 4001: ErrorMsg="Wrong function pointer.";                                        break;
      case 4002: ErrorMsg="Array index is out of range.";                                   break;
      case 4003: ErrorMsg="No memory for function call stack.";                             break;
      case 4004: ErrorMsg="Recursive stack overflow.";                                      break;
      case 4005: ErrorMsg="Not enough stack for parameter.";                                break;
      case 4006: ErrorMsg="No memory for parameter string.";                                break;
      case 4007: ErrorMsg="No memory for temp string.";                                     break;
      case 4008: ErrorMsg="Not initialized string.";                                        break;
      case 4009: ErrorMsg="Not initialized string in array.";                               break;
      case 4010: ErrorMsg="No memory for array string.";                                    break;
      case 4011: ErrorMsg="Too long string.";                                               break;
      case 4012: ErrorMsg="Remainder from zero divide.";                                    break;
      case 4013: ErrorMsg="Zero divide.";                                                   break;
      case 4014: ErrorMsg="Unknown command.";                                               break;
      case 4015: ErrorMsg="Wrong jump (never generated error).";                            break;
      case 4016: ErrorMsg="Not initialized array.";                                         break;
      case 4017: ErrorMsg="Dll calls are not allowed.";                                     break;
      case 4018: ErrorMsg="Cannot load library.";                                           break;
      case 4019: ErrorMsg="Cannot call function.";                                          break;
      case 4020: ErrorMsg="Expert function calls are not allowed.";                         break;
      case 4021: ErrorMsg="Not enough memory for temp string returned from function.";      break;
      case 4022: ErrorMsg="System is busy (never generated error).";                        break;
      case 4023: ErrorMsg="Dll-function call critical error.";                              break;
      case 4024: ErrorMsg="Internal error.";                                                break;
      case 4025: ErrorMsg="Out of memory.";                                                 break;
      case 4026: ErrorMsg="Invalid pointer.";                                               break;
      case 4027: ErrorMsg="Too many formatters in the format function.";                    break;
      case 4028: ErrorMsg="Parameters count exceeds formatters count.";                     break;
      case 4029: ErrorMsg="Invalid array.";                                                 break;
      case 4030: ErrorMsg="No reply from chart.";                                           break;
      case 4050: ErrorMsg="Invalid function parameters count.";                             break;
      case 4051: ErrorMsg="Invalid function parameter value.";                              break;
      case 4052: ErrorMsg="String function internal error.";                                break;
      case 4053: ErrorMsg="Some array error.";                                              break;
      case 4054: ErrorMsg="Incorrect series array using.";                                  break;
      case 4055: ErrorMsg="Custom indicator error.";                                        break;
      case 4056: ErrorMsg="Arrays are incompatible.";                                       break;
      case 4057: ErrorMsg="Global variables processing error.";                             break;
      case 4058: ErrorMsg="Global variable not found.";                                     break;
      case 4059: ErrorMsg="Function is not allowed in testing mode.";                       break;
      case 4060: ErrorMsg="Function is not allowed for call.";                              break;
      case 4061: ErrorMsg="Send mail error.";                                               break;
      case 4062: ErrorMsg="String parameter expected.";                                     break;
      case 4063: ErrorMsg="Integer parameter expected.";                                    break;
      case 4064: ErrorMsg="Double parameter expected.";                                     break;
      case 4065: ErrorMsg="Array as parameter expected.";                                   break;
      case 4066: ErrorMsg="Requested history data is in updating state.";                   break;
      case 4067: ErrorMsg="Internal trade error.";                                          break;
      case 4068: ErrorMsg="Resource not found.";                                            break;
      case 4069: ErrorMsg="Resource not supported.";                                        break;
      case 4070: ErrorMsg="Duplicate resource.";                                            break;
      case 4071: ErrorMsg="Custom indicator cannot initialize.";                            break;
      case 4072: ErrorMsg="Cannot load custom indicator.";                                  break;
      case 4073: ErrorMsg="No history data.";                                               break;
      case 4074: ErrorMsg="No memory for history data.";                                    break;
      case 4075: ErrorMsg="Not enough memory for indicator calculation.";                   break;
      case 4099: ErrorMsg="End of file.";                                                   break;
      case 4100: ErrorMsg="Some file error.";                                               break;
      case 4101: ErrorMsg="Wrong file name.";                                               break;
      case 4102: ErrorMsg="Too many opened files.";                                         break;
      case 4103: ErrorMsg="Cannot open file.";                                              break;
      case 4104: ErrorMsg="Incompatible access to a file.";                                 break;
      case 4105: ErrorMsg="No order selected.";                                             break;
      case 4106: ErrorMsg="Unknown symbol.";                                                break;
      case 4107: ErrorMsg="Invalid price.";                                                 break;
      case 4108: ErrorMsg="Invalid ticket.";                                                break;
      case 4109: ErrorMsg="Trade is not allowed in the Expert Advisor properties.";         break;
      case 4110: ErrorMsg="Longs are not allowed in the Expert Advisor properties.";        break;
      case 4111: ErrorMsg="Shorts are not allowed in the Expert Advisor properties.";       break;
      case 4112: ErrorMsg="Automated trading disabled by trade server.";                    break;
      case 4200: ErrorMsg="Object already exists.";                                         break;
      case 4201: ErrorMsg="Unknown object property.";                                       break;
      case 4202: ErrorMsg="Object does not exist.";                                         break;
      case 4203: ErrorMsg="Unknown object type.";                                           break;
      case 4204: ErrorMsg="No object name.";                                                break;
      case 4205: ErrorMsg="Object coordinates error.";                                      break;
      case 4206: ErrorMsg="No specified subwindow.";                                        break;
      case 4207: ErrorMsg="Graphical object error.";                                        break;
      case 4210: ErrorMsg="Unknown chart property.";                                        break;
      case 4211: ErrorMsg="Chart not found.";                                               break;
      case 4212: ErrorMsg="Chart subwindow not found.";                                     break;
      case 4213: ErrorMsg="Chart indicator not found.";                                     break;
      case 4220: ErrorMsg="Symbol select error.";                                           break;
      case 4250: ErrorMsg="Notification error.";                                            break;
      case 4251: ErrorMsg="Notification parameter error.";                                  break;
      case 4252: ErrorMsg="Notifications disabled.";                                        break;
      case 4253: ErrorMsg="Notification send too frequent.";                                break;
      case 4260: ErrorMsg="FTP server is not specified.";                                   break;
      case 4261: ErrorMsg="FTP login is not specified.";                                    break;
      case 4262: ErrorMsg="FTP connection failed.";                                         break;
      case 4263: ErrorMsg="FTP connection closed.";                                         break;
      case 4264: ErrorMsg="FTP path not found on server.";                                  break;
      case 4265: ErrorMsg="File not found in the Files directory to send on FTP server.";   break;
      case 4266: ErrorMsg="Common error during FTP data transmission.";                     break;
      case 5001: ErrorMsg="Too many opened files.";                                         break;
      case 5002: ErrorMsg="Wrong file name.";                                               break;
      case 5003: ErrorMsg="Too long file name.";                                            break;
      case 5004: ErrorMsg="Cannot open file.";                                              break;
      case 5005: ErrorMsg="Text file buffer allocation error.";                             break;
      case 5006: ErrorMsg="Cannot delete file.";                                            break;
      case 5007: ErrorMsg="Invalid file handle (file closed or was not opened).";           break;
      case 5008: ErrorMsg="Wrong file handle (handle index is out of handle table).";       break;
      case 5009: ErrorMsg="File must be opened with FILE_WRITE flag.";                      break;
      case 5010: ErrorMsg="File must be opened with FILE_READ flag.";                       break;
      case 5011: ErrorMsg="File must be opened with FILE_BIN flag.";                        break;
      case 5012: ErrorMsg="File must be opened with FILE_TXT flag.";                        break;
      case 5013: ErrorMsg="File must be opened with FILE_TXT or FILE_CSV flag.";            break;
      case 5014: ErrorMsg="File must be opened with FILE_CSV flag.";                        break;
      case 5015: ErrorMsg="File read error.";                                               break;
      case 5016: ErrorMsg="File write error.";                                              break;
      case 5017: ErrorMsg="String size must be specified for binary file.";                 break;
      case 5018: ErrorMsg="Incompatible file (for string arrays-TXT, for others-BIN).";     break;
      case 5019: ErrorMsg="File is directory, not file.";                                   break;
      case 5020: ErrorMsg="File does not exist.";                                           break;
      case 5021: ErrorMsg="File cannot be rewritten.";                                      break;
      case 5022: ErrorMsg="Wrong directory name.";                                          break;
      case 5023: ErrorMsg="Directory does not exist.";                                      break;
      case 5024: ErrorMsg="Specified file is not directory.";                               break;
      case 5025: ErrorMsg="Cannot delete directory.";                                       break;
      case 5026: ErrorMsg="Cannot clean directory.";                                        break;
      case 5027: ErrorMsg="Array resize error.";                                            break;
      case 5028: ErrorMsg="String resize error.";                                           break;
      case 5029: ErrorMsg="Structure contains strings or dynamic arrays.";                  break;
      case 5200: ErrorMsg="Invalid URL.";                                                   break;
      case 5201: ErrorMsg="Failed to connect to specified URL.";                            break;
      case 5202: ErrorMsg="Timeout exceeded.";                                              break;
      case 5203: ErrorMsg="HTTP request failed.";                                           break;
      
      // Custum Error
      case 10000: ErrorMsg="Margin Level Reach Limit.";                                      break;
      default:    ErrorMsg="Unknown error.";
     }
     CaptureErr = ErrorCode;
   return(ErrorMsg);
  }
//+-----------------------------------------------------------------------------------------------------------------+
//| Script End                                                                                                      |
//+-----------------------------------------------------------------------------------------------------------------+
