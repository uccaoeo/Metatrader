//+------------------------------------------------------------------+
//|                                RT_MA_Pullback_StrategyConfig.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <EA\PortfolioManagerBasedBot\BasePortfolioManagerBotConfig.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct RT_MA_Pullback_StrategyConfig : public BasePortfolioManagerBotConfig
  {
public:
   ENUM_TIMEFRAMES   timeframe;
   int               maPeriod; // Period of directional bias MA.
   color             maColor; // Color of directional bias indcator.
   int               maPullbackTests; // How many times should price test the area of value?
   int               maPullbackPeriod; // Period of Area of Value MA upper boundary.
   color             maPullbackColor; // Color of Area of Value MA upper boundary.
   int               maThresholdPeriod; // Period of Area of Value MA lower boundary.
   color             maThresholdColor; // Color of Area of Value MA lower boundary.
   double            minimumTpSlDistance; // Tp/Sl minimum distance, in spreads.
   int               exitsByHighLowPeriod; // Period for set exits by high and low. (Trend trader mode = false).
   color             exitSignalColor;  // Color of the exit signal indicator.
   bool              followTrend; // Enable trend trader mode?
   int               followTrendTrailingStopPeriod; // Period for trend follower trailing stop.
   bool              initializeTrailingStopTo1Atr; // Set initial trend follower trailing stop to 1 Atr away.
  };
//+------------------------------------------------------------------+
