//+------------------------------------------------------------------+
//|                                                     AtrRange.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Signals\AtrBase.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AtrRange : public AtrBase
  {
public:
                     AtrRange(int period,double atrMultiplier,ENUM_TIMEFRAMES timeframe,double skew,int shift=0,double minimumSpreadsTpSl=1,color indicatorColor=clrAquamarine);
   SignalResult     *Analyzer(string symbol,int shift);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
AtrRange::AtrRange(int period,double atrMultiplier,ENUM_TIMEFRAMES timeframe,double skew,int shift=0,double minimumSpreadsTpSl=1,color indicatorColor=clrAquamarine):AtrBase(period,atrMultiplier,timeframe,skew,shift,minimumSpreadsTpSl,indicatorColor)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SignalResult *AtrRange::Analyzer(string symbol,int shift)
  {
   PriceRange pr=this.CalculateRangeByPriceLowHighMidpoint(symbol,shift);

   MqlTick tick;
   bool gotTick=SymbolInfoTick(symbol,tick);

   double height=pr.high-pr.low;
   double ctr=pr.mid;
   double top=pr.high;
   double bottom=pr.low;
   
   if(gotTick)
     {
      if(tick.bid>=pr.mid)
        {
         ctr=ctr+((height)*this._skew);
         top=tick.ask+(pr.high-ctr);
         bottom=tick.ask-(ctr-pr.low);
         
         this.Signal.isSet=true;
         this.Signal.time=tick.time;
         this.Signal.symbol=symbol;
         this.Signal.orderType=OP_SELL;
         this.Signal.price=tick.bid;
         this.Signal.stopLoss=top;
         this.Signal.takeProfit=bottom;
        }
      if(tick.ask<=pr.mid)
        {
         ctr=ctr-((height)*this._skew);
         top=tick.bid+(pr.high-ctr);
         bottom=tick.bid-(ctr-pr.low);
         
         this.Signal.isSet=true;
         this.Signal.time=tick.time;
         this.Signal.symbol=symbol;
         this.Signal.orderType=OP_BUY;
         this.Signal.price=tick.ask;
         this.Signal.stopLoss=bottom;
         this.Signal.takeProfit=top;
        }
     }

   this.DrawIndicatorRectangle(symbol,shift,top,bottom);
   
   return this.Signal;
  }
//+------------------------------------------------------------------+
