/*
 * @file
 * Defines default strategy parameter values for the given timeframe.
 */

// Defines indicator's parameter values for the given pair symbol and timeframe.
struct Indi_Indicator_Params_H1 : IndiIndicatorParams {
  Indi_Indicator_Params_H1() : IndiIndicatorParams(indi_indi_defaults, PERIOD_H1) { shift = 0; }
} indi_indi_h1;

// Defines strategy's parameter values for the given pair symbol and timeframe.
struct Stg_Indicator_Params_H1 : StgParams {
  // Struct constructor.
  Stg_Indicator_Params_H1() : StgParams(stg_indi_defaults) {}
} stg_indi_h1;
