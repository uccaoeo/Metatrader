//+------------------------------------------------------------------+
//|                                                 MonkeyConfig.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <EA\PortfolioManagerBasedBot\BasePortfolioManagerBotConfig.mqh>
#include <Signals\Config\MonkeySignalConfig.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct MonkeyConfig : public BasePortfolioManagerBotConfig
  {
public:
   MonkeySignalConfig monkeySignal;
  };
//+------------------------------------------------------------------+
