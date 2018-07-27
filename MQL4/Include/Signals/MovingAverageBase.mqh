//+------------------------------------------------------------------+
//|                                            MovingAverageBase.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Common\Comparators.mqh>
#include <Signals\AbstractSignal.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MovingAverageBase : public AbstractSignal
  {
protected:
   Comparators       _compare;
   int               _maShift;
   ENUM_MA_METHOD    _maMethod;
   ENUM_APPLIED_PRICE _maAppliedPrice;
public:
                     MovingAverageBase(int period,ENUM_TIMEFRAMES timeframe,ENUM_MA_METHOD maMethod,ENUM_APPLIED_PRICE maAppliedPrice,int maShift,int shift=0,color indicatorColor=clrHotPink);
   virtual bool      Validate(ValidationResult *v);
   virtual SignalResult *Analyze(string symbol,int shift)=0;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MovingAverageBase::MovingAverageBase(int period,ENUM_TIMEFRAMES timeframe,ENUM_MA_METHOD maMethod,ENUM_APPLIED_PRICE maAppliedPrice,int maShift,int shift=0,color indicatorColor=clrHotPink):AbstractSignal(period,timeframe,shift,indicatorColor)
  {
   this._maMethod=maMethod;
   this._maAppliedPrice=maAppliedPrice;
   this._maShift=maShift;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MovingAverageBase::Validate(ValidationResult *v)
  {
   AbstractSignal::Validate(v);

   if(!this._compare.IsNotBelow(this._maShift,0))
     {
      v.Result=false;
      v.AddMessage("maShift must be 0 or greater.");
     }

   return v.Result;
  }
//+------------------------------------------------------------------+
