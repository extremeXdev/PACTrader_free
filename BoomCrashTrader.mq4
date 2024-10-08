
//+------------------------------------------------------------------+
//|                                                    PACTrader.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                            https://www.mql5.com/users/traorestan |
//+------------------------------------------------------------------+

#property strict

enum ENUM_OP_TYPE
  {
      //OpNo        = -1,             // Select...
      OpBuy       = OP_BUY,         // Buy
      OpSell      = OP_SELL,        // Sell
      //OpBuyLimit  = OP_BUYLIMIT,    // Buy Limit
      //OpSellLimit = OP_SELLLIMIT,   // Sell Limit
      //OpBuyStop   = OP_BUYSTOP,     // Buy Stop
      //OpSellStop  = OP_SELLSTOP     // Sell Stop
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
     Free_Tmode            // Free Trading
};

enum ENUM_AUTO_MAN_MODE {
   Automatic_Tmode,      // Automatic
   Manual_Tmode         // Manual
};

enum ENUM_COMMENT_MODE {
   Simple_Com,               // Simple 
   Normal_Com,              // Normal
   Full_Com                // Full
};



 
 extern string _Orders_= "------------------------------------";  // Orders Settup

 extern ENUM_OP_TYPE MainOrder = OpSell;
 extern double LotInitial=0.01;
 extern double Multiplier=1.3;                                          // Multiplicator
 extern int TakeProfit=60;
 extern int MaxPosNb=20;                                      // Maximum Orders Position
 extern int Slippage=20;                                     // Slippage
 extern int MagicNumber=0;                                  // Magic Number
 extern bool EnableAutoMoneyManagement = true;             // Auto Risk Mode
 
 extern int Sp;
 extern double Pi;
 
 extern string _TTime_= "------------------------------------";   // Trading Time Settup
 extern bool EnableRobotTradeAtPrefTime = True;                  // Enable Trade At Prefered Time
 extern bool UseLocalTimeInsteadOfFx = false;                   // Use Local Time Instead of Fx
 extern bool EnableTimezoneChange = true;                      // Enable Timezone Change
 extern int StartTime = 0;                                    // Start hour of Trading day
 extern int CloseTime = 11;                                  // End hour of Trading day
 extern int StartTime2 = 18;                                //Start hour 2 of Trading day
 extern int CloseTime2 = 24;                               // End hour 2 of Trading day
 extern int NbDayTrade = 5;                               // Numbers Day Trade
 extern bool EnableCloseXMinuteBefore = false;           // Enable Close X Minutes Before
 extern int  XMinuteBefore = 40;                        // X Minute Before CloseTime
 extern bool EnableMarketOpenWait = false;             // Enable Market Open X Minute Wait
 extern int MarketOpenXMinuteWait = 10;               // X MinuteWait

extern string _Mis_= "------------------------------------";   // Miscelleaneous
extern ENUM_COMMENT_MODE Comment_Mode = Full_Com;             // Comment Mode
extern string  OrdComment   = "STN";                         // Order Comment
extern bool EnableNotifByEmail=true;                        // Enable Notification By Email
extern bool EnablePushNotif=true;
 
 int Ret=0;
 int errCode=0;
 int OrdNbX=0;
 
 bool Interrupt = false;
 bool RobotRun=true;
 bool PlacePos=false;

 bool PrintIt1Time=false;

 int Pn, Pf;
 double lot,LastLot, RST, RPT, Rs, Rp;
 
 double SellLastPosLot=0;
 double SellLastPosPrice=0;
 int SellLastPosTp=0;
 datetime SellLastPosBarTime=0;

 double SellNextPosLot=0;
 double SellNextPosTp=0;
 int SellNextOrderNb;
 
 double BuyNextPosLot=0;
 double BuyNextPosTp=0;
 int BuyNextOrderNb=0;
 

 double BuyLastPosLot=0;
 double BuyLastPosPrice=0;
 int BuyLastPosTp=0;
 datetime BuyLastPosBarTime=0;
 
 bool accept;
 char out;
 
 int v=0;
 int SellOrdersNb=0;
 int BuyOrdersNb=0;
 int orders=0;
 int ticket =0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
   
//---
   return(INIT_SUCCEEDED);
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
      Trader();
  }
  
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
  }
  
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,const long &lparam, const double &dparam, const string &sparam)
  {
//---
  }
//+------------------------------------------------------------------+


void Trader(){

   // Verify if Trade Allowed
   if(!IsTradeAllowed()){
      RobotRun=false;
      Alert("Autotrade is NOT allowed.");
      return;
   }else {RobotRun=true;}
   

   // Verify if Interuuption is called
   if(Interrupt && RobotRun=true && OrdersTotal()==0){
      RobotRun=false;   // Set Robot Off
  
      if(PrintIt1Time) {
         Print("Robot Interrupted...");
         PrintIt1Time=false;
         MessageBox("System going to close all Orders...until further notice",NULL,MB_OK);
       }
    }else {PrintIt1Time=true;}

   // Trade if robot allowed
   if(RobotRun){
      
       //if(MainOrder==OpSell){GetNbOfPosition(OpSell);}
       //else if(MainOrder==OpBuy){GetNbOfPosition(OpBuy);}
       
      //////////////// Select Both last Orders
         ticket = OrdersTotal();
         for(int i=ticket; i > (ticket-2), i--){  // execute 2 times
            if(OrderSelect(ticket, SELECT_BY_POS)){
               if(OrderType()==OpSell){
                  SellLastPosPrice = OrderOpenPrice();
                  SellLastPosLot = OrderLots();
                  SellLastPosTp = OrderTakeProfit();
                  SellLastPosBarTime= OrderOpenTime();
               }else if(OrderType()==OpBuy){
                  BuyLastPosPrice = OrderOpenPrice();
                  BuyLastPosLot= OrderLots();
                  BuyLastPosTp=OrderTakeProfit();
                  BuyLastPosBarTime=OrderOpenTime();
               }
            }
         }
      // Calculate Next Position Lot
      SellNextPosLot = CalcLoti(OpSell);
      BuyNextPosLot = CalcLoti(OpBuy);
      
      //Recover Last Existing Positions Properties
      
      // Contrôl adding Position condition
      if(OrdersTotal()!=0){
         if(MainOrder == OpSell && SellOrdersNb < MaxPosNb && Ask <= NormalizeDouble(SellLastPosPrice - (TakeProfit*Point), Digits)){ //For Sell Orders
            PlacePos=true;
         }else{PlacePos=false;}
      }else {
         PlacePos=true;
       }
      
      //if(MainOrder == OpBuy && Bid >= NormalizeDouble(BuyLastPosPrice + (TakeProfit*Point), Digits)) {
         //PlacePos=true;
      //}else{}
      
      //Place both Trade Buy-Sell
      if(PlacePos){
         PlacePosition(SellNextPosLot, Bid, 0, 0, OpSell);  // Sell Position placing
         PlacePosition(BuyNextPosLot, Ask, 0, 0, OpBuy);   // Buy Position Placing
         
         SellNextPosLot=0;
         BuyNextPosLot=0;
      }
      
      ///////////////// Manage All Take Profits (Buy Orders Independly of Sell Orders)
      
      ////////////////////////
      
      // Display Results
   }
}


double CalcLoti(ENUM_OP_TYPE OrdTyp)
  {
  
            // Rcover number of positions existing
       
         if(OrdTyp==OpSell){
            SellOrdersNb = GetNbOfPosition(OpSell);
            if(SellOrdersNb==0){
               Lot = LotInitial;
            }else {
               LastLot = SellLastPosLot;
            }
         }else(OrdTyp==OpBuy){
            BuyOrdersNb = GetNbOfPosition(OpBuy);
            if(BuyOrdersNb==0){
               Lot=LotInitial;
            }else {
               LastLot = BuyLastPosLot;
            }
         }
            
        Lot=LastLot*Multiplier;            // Multiplicateur successif
    
        if(Lot > LastLot) {
           Lot=round(Lot*100)/100;    // else we make usually round
        } else {
            Lot=ceil(Lot*100)/100;    // if it's denieded to repeat we make ceil
        }
       
       
       return Lot;
  }


void Trade(ENUM_OP_TYPE OrdTyp, double Given_Tp=0)
  {
  
   CaptureErr=0;
   Sl=0; Tp=0; PRICE=0; TickVal=0; RISK=0; Vol=0; Profit=0;

   //--- Checks the input parameters
   if(OrdTyp == OpNo)
     {Alert("Please select Order Operation Type."); return;}
   if((OrdTyp == OpBuy || OrdTyp == OpSell) && (EntryLevelBy != EntryLevelNo || EntryLevel != 0))
     {
      ErrMsg = "Please do not enter Set Pending Order Entry Level By or\n"
               "Pending Order Entry Level at the opening of an immediate\n"
               "execution order.";
      Alert(ErrMsg);
      return;
     }


   if(OrdTyp != OpBuy && OrdTyp != OpSell && (EntryLevelBy == EntryLevelNo || EntryLevel <= 0))
     {
      ErrMsg = "Please enter Set Pending Order Entry Level By and\n"
               "Pending Order Entry Level at the opening of an pending order.";
      Alert(ErrMsg);
      return;
     }

   if(Risk <= 0)
     {Alert("Please enter the Order Risk."); return;}
   if(StopLoss <= 0)
     {Alert("Please enter the Stop Loss."); return;}


//--- Initializes stop loss and take profit
   Sl = NormalizeDouble(StopLoss, Digits);
   Tp = NormalizeDouble(TakeProfit, Digits);



//--- Checks order buy
   if(OrdTyp == OpBuy)
     {
      //--- PRICE
      PRICE = Ask;

      //--- Stop Loss
      if(StopLossBy == SL_Points)
        {Sl = NormalizeDouble(PRICE - StopLoss*Point, Digits);}

      //--- Risk
      RISK = Risk;
      if(RiskBy == RiskPercentage)
        {RISK = (AccountBalance() + AccountCredit()) * (Risk / 100);}

      //--- Volume
      TickVal = ((PRICE - Sl) / Point) * SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE);

      if(TickVal == 0.0) {Vol = 0.0;}
      else
        {Vol = NormalizeDouble(RISK / TickVal, 2);}

      Vol = ControlVolume();

      if(Given_Tp!=0)
        {TakeProfit=Given_Tp;}


      //--- Calculate Take Profit when Tp is Point
      if(TakeProfit > 0 && TakeProfitBy != TP_Price)
        {
         if(TakeProfitBy == TP_Points)
           {Tp = NormalizeDouble(PRICE + TakeProfit * Point, Digits);}
         else
           {
            Profit = TakeProfit;
            if(TakeProfitBy == TP_Percentage)
              {Profit = (AccountBalance() + AccountCredit()) * (TakeProfit / 100);}
            Tp = NormalizeDouble(PRICE + (Profit / SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) * Vol) * Point, Digits);
           }
        }


      ////////////////////

      if((UseRecentTopBidInstead==true && RecentTopBid!=0) || (UseRecentTopBidInstead==false))   //when we have recent Top Bid
        {
         if(Ask<PivotPrice)
           {

            if(ReversalTp>PivotPrice)
              {
                  if(RemoveBuySL){Sl=0;}
                  if(!EnableSwitchingOrderSend)
                    {
                        AddMultiplePosition(Vol, PRICE, Sl, ReversalTp, OpBuy);
                        if(AddReversalOrder && AcceptBuyReversal) {
                           if(OrdersTotal()!=0)  // when there are existing Buy orders
                             {AddMultiplePendingPosition(Vol, ReversalTp, 0, TakeProfit, OpSellLimit);}
                        } else { Print("Buy Reversal Not Permitted...");}
                        
                    }else
                        {
                        // Switching order send algo here
      
                        for(z=0; z<NbPos; z+=bu)  // positions number to reach
                          {
                              AddMultiplePosition(Vol, PRICE, Sl, ReversalTp, OpBuy, bu);
                              if(AddReversalOrder && AcceptBuyReversal){
                                 if(OrdersTotal()!=0)  // when there are existing Buy orders
                                   { AddMultiplePendingPosition(Vol, ReversalTp, 0, TakeProfit, OpSellLimit, bu);}
                              }
         
                              if(CaptureErr!=0) { break;}  //go out where error occur
                          }
                    }
                    
                     if(PlayASound) {
                        if(PlaySound(Snd)){Print("Sound Played");};
                     }
                  
              } else {Alert("TakeProfit have To Be Higher Than Pivot Price...");}
          } else { Alert("Cannot Buy Here...");}
        } else {Print("Cannot Add Position, Recent Top Bid Cannot equal 0...");}

      ///////////////////

     }
//--- Checks order sell
   else if(OrdTyp == OpSell)
        {
         //--- Price
         PRICE = Bid;

         //--- Stop Loss
         if(StopLossBy == SL_Points)
           {Sl = NormalizeDouble(PRICE + StopLoss * Point, Digits);}

         //--- Risk
         RISK = Risk;
         if(RiskBy == RiskPercentage)
           {RISK = (AccountBalance() + AccountCredit()) * (Risk / 100);}

         //--- Volume
         TickVal = ((Sl - PRICE) / Point) * SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE);;

         if(TickVal == 0.0)
           {Vol = 0.0;}
         else
            {Vol = NormalizeDouble(RISK / TickVal, 2);}

         Vol = ControlVolume();
         if(Given_Tp!=0) {TakeProfit=Given_Tp;}


         //---Calculate Take Profit when Tp is Point
         if(TakeProfit > 0 && TakeProfitBy != TP_Price) {
            if(TakeProfitBy == TP_Points)
              {Tp = NormalizeDouble(PRICE - TakeProfit*Point, Digits);}
            else {
               Profit = TakeProfit;
               if(TakeProfitBy == TP_Percentage)
                 {
                  Profit = (AccountBalance() + AccountCredit()) * (TakeProfit / 100);
                 }
               Tp = NormalizeDouble(PRICE - (Profit / (SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) * Vol)) * Point, Digits);
              }
         }

         ////////////////
         if(Bid>PivotPrice)
           {
               if(!EnableSwitchingOrderSend) {
                  AddMultiplePosition(Vol, PRICE, StopLossPrice, TakeProfit, OpSell);
                  if(AddReversalOrder) {
                     if(OrdersTotal()!=0)  // when there are existing sell orders
                       {AddMultiplePendingPosition(Vol, TakeProfit, StopLossPrice, ReversalTp, OpBuyLimit);}
                   }
               }
               
               if(PlaySound(Snd)){Print("Sound Played");}
            }
         
      }
  }
/*
//+------------------------------------------------------------------+
//| function                                                         |
//+------------------------------------------------------------------+
double CalcLot(ENUM_OP_TYPE OrdTyp, int NextPosNb=1)
  {

   //Recalculating values
    accept=true;

    Pn=0;
    Lot=LotInitial;
    LastLot=LotInitial;

    Rs=Lot*Sp;
    RST=Rs;

    Pf= (Tp*NbPosMax)-Tp;

    Rp=Lot*(Pf-Pn);
    RPT=Rp;
    
    v = NextPosNb;
    for (v = SellOrdersNb; v < NbPosMax; v++) {
        Pn=Pn+Tp;
        Pi=Pi+Tp;

        Lot=Lot*Mu;            // Multiplicateur successif



        if(accept == false) {
            Lot=ceil(lot*100)/100;    // if it's denieded to repeat we make ceil
        } else {
            lot=round(lot*100)/100;    // else we make usually round
        }

        if( Lot > LastLot) {
            accept=true;            // one accept to repeat
        } else {
            Lot= LastLot;
            accept = false;        //one denied to repeat
        }



        last_lot = lot;        // lot de la boucle précédente

        Rs=lot*Sp;            // Multiplicateur successif
        RST= RST+Rs;         // sommateur successif

        Rp=lot*(Pf-Pn);     // Multiplicateur successif
        RPT=RPT+Rp;        // sommateur successif
   
    }
    
  }
 */
 
 
 void PlacePosition(double Lot, double Price, double SL, double TP, ENUM_OP_TYPE OrdTyp)
   {
      errcode = 0;
      Ret = 0;
      _cpt=1;

      if(int i=0; errcode!=132 && errcode !=134 && CaptureErr !=130 && i < NbPosMax, i++) // if market not closed, not have enough money, Not Invalid Stop and max pos nb not reached
        {
            
            if(OrdTyp==OpBuy || OrdTyp==OpSell) {
               Ret = OrderSend(Symbol(), OrdTyp, Lot, Price, Slippage, SL, TP, CommentThat(cpt) , MagicNumber, 0, clrNONE);
            }
            
            errcode = GetLastError();
            
            LastPositionSavedTp = TP;  // the last position executed take profit
      
            if(Ret == -1) {
                  if(OrdTyp==OpSell)
                    {Alert("Sell Trade error: "+ErrorDescription(errcode));}
                  else
                    {Alert("Buy Trade error: "+ErrorDescription(errcode));}
   
                  break;
            }else {
                if(cpt<NbPos){cpt++;_cpt++;NbTotalTrade++;}else{cpt=0;_cpt=0;}
            }
        }
   }



int GetNbOfPosition(ENUM_OP_TYPE OrdTyp){
   ticket=0;
       
   if(OrdTyp==OpSell){ // Recover numbers of Sell position
      SellOrdersNb=0;
      
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
            ticket=OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES);
            
            if(OrderMagicNumber()==MagicNumber && OrderType()==OpSell)
              {SellOrdersNb++}
        }
      return SellOrdersNb;
      
   }else if(OrdTyp==OpBuy) { // Recover numbers of Buy position
      BuyOrdersNb=0;
 
       for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
            ticket=OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES);
            
            if(OrderMagicNumber()==MagicNumber && OrderType()==OpBuy)
              {BuyOrdersNb++}
        }
        
        return BuyOrdersNb;
   }  
} 

//+----------------------------------------------------------------------------------------+
//|     CommentThat function                                                               |
//+----------------------------------------------------------------------------------------+
string CommentThat(int m)
   {
      if(Comment_Mode == Full_Com) {
         return OrdComment +" "+ IntegerToString(_m) +" "+ IntegerToString(z+_m) +" "+
               IntegerToString(m) +" "+ IntegerToString(NbTotalTrade);
      }else if(Comment_Mode==Normal_Com) {
         return OrdComment + " " + IntegerToString(_m)+ " "+ IntegerToString(z+_m) +" " +
               IntegerToString(m);
      }else {
         return OrdComment + " " + IntegerToString(_m)+ " "+ IntegerToString(z+_m);
      }
   }
//+-------------------------------------------------------------------------------------------+


   
 //+------------------------------------------------------------------------------------+
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
