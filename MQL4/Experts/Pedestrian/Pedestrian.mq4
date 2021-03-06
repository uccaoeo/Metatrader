//+------------------------------------------------------------------+
//|                                                   Pedestrian.mq4 |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property description "Does Magic."
#property strict

#include <EA\Pedestrian\Pedestrian.mqh>
#include <EA\Pedestrian\PedestrianSettings.mqh>
#include <EA\Pedestrian\PedestrianConfig.mqh>

Pedestrian *bot;
#include <EA\PortfolioManagerBasedBot\BasicEATemplate.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void init()
  {
   PedestrianConfig config;

   GetBasicConfigs(config);

   config.botPeriod=BotPeriod;
   config.botTimeframe=PortfolioTimeframe;
   config.botMinimumTpSlDistance=BotMinimumTpSlDistance;
   config.botSkew=BotSkew;
   config.botAtrMultiplier=BotAtrMultiplier;
   config.botRangePeriod=BotRangePeriod;
   config.botIntradayPeriod=BotIntradayPeriod;
   config.botIntradayTimeframe=BotIntradayTimeframe;

   bot=new Pedestrian(config);
  }
//+------------------------------------------------------------------+
