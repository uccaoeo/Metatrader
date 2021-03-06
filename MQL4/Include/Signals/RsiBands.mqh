//+------------------------------------------------------------------+
//|                                                     RsiBands.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Signals\RsiBase.mqh>
#include <Signals\Config\RsiBandsConfig.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class RsiBands : public RsiBase
  {
private:
   HighLowThresholds _midband;
   HighLowThresholds _nullband;
public:
                     RsiBands(RsiBandsConfig &config,AbstractSignal *aSubSignal=NULL);
   SignalResult     *Analyzer(string symbol,int shift);
   bool              IsInMidBand(string symbol,int shift);
   bool              IsInNullBand(string symbol,int shift);
   bool              IsSellSignal(string symbol,int shift);
   bool              IsBuySignal(string symbol,int shift);
   virtual bool Validate(ValidationResult *v);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
RsiBands::RsiBands(RsiBandsConfig &config,AbstractSignal *aSubSignal=NULL):RsiBase(config,aSubSignal)
  {
   this._midband=config.Midband;
   this._nullband=config.Nullband;
  }
bool RsiBands::Validate(ValidationResult *v)
{
   RsiBase::Validate(v);
   
   if(this._compare.IsNotBetween(this._midband.High,0.0,100.0))
     {
      v.Result=false;
      v.AddMessage("Midband High must be between 0 and 100.");
     }
   
   if(this._compare.IsNotBetween(this._midband.Low,0.0,100.0))
     {
      v.Result=false;
      v.AddMessage("Midband Low must be between 0 and 100.");
     }
   
   if(this._compare.IsNotBetween(this._nullband.High,0.0,100.0))
     {
      v.Result=false;
      v.AddMessage("Nullband High must be between 0 and 100.");
     }
   
   if(this._compare.IsNotBetween(this._nullband.Low,0.0,100.0))
     {
      v.Result=false;
      v.AddMessage("Nullband Low must be between 0 and 100.");
     }
     
   return v.Result;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SignalResult *RsiBands::Analyzer(string symbol,int shift)
  {
   PriceRange pr=this.CalculateRangeByPriceLowHigh(symbol,shift);
   this.DrawIndicatorRectangle(symbol,shift,pr.high,pr.low);

   bool sellSignal=this.IsSellSignal(symbol,shift);
   bool buySignal=this.IsBuySignal(symbol,shift);

   MqlTick tick;

   if(SymbolInfoTick(symbol,tick) && this._compare.Xor(buySignal,sellSignal))
     {
      if(sellSignal)
        {
         this.Signal.isSet=true;
         this.Signal.time=tick.time;
         this.Signal.symbol=symbol;
         this.Signal.orderType=OP_SELL;
         this.Signal.price=tick.bid;
         this.Signal.stopLoss=0;
         this.Signal.takeProfit=0;
        }
      else if(buySignal)
        {
         this.Signal.isSet=true;
         this.Signal.orderType=OP_BUY;
         this.Signal.price=tick.ask;
         this.Signal.symbol=symbol;
         this.Signal.time=tick.time;
         this.Signal.stopLoss=0;
         this.Signal.takeProfit=0;
        }
     }

// signal confirmation
   if(!this.DoesSubsignalConfirm(symbol,shift))
     {
      this.Signal.Reset();
     }

   return this.Signal;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RsiBands::IsInMidBand(string symbol,int shift)
  {
   return this._compare.IsBetween(this.GetRsi(symbol,shift),this._midband.Low,this._midband.High);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RsiBands::IsInNullBand(string symbol,int shift)
  {
   return this._compare.IsBetween(this.GetRsi(symbol,shift),this._nullband.Low,this._nullband.High);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RsiBands::IsSellSignal(string symbol,int shift)
  {
   return (!this.IsInNullBand(symbol,shift)) && (((this.IsBearish(symbol,shift) && !this.IsOversold(symbol,shift)) || this.IsOverbought(symbol,shift)));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RsiBands::IsBuySignal(string symbol,int shift)
  {
   return (!this.IsInNullBand(symbol,shift)) && (((this.IsBullish(symbol,shift) && !this.IsOverbought(symbol,shift)) || this.IsOversold(symbol,shift)));
  }
//+------------------------------------------------------------------+
