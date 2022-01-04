/**
 * @file
 * Implements Indicator strategy to run common or custom indicators.
 */

// User input params.
INPUT_GROUP("Indicator strategy: strategy params");
INPUT float Indicator_LotSize = 0;                // Lot size
INPUT int Indicator_SignalOpenMethod = 0;         // Signal open method
INPUT float Indicator_SignalOpenLevel = 0;        // Signal open level
INPUT int Indicator_SignalOpenFilterMethod = 32;  // Signal open filter method
INPUT int Indicator_SignalOpenFilterTime = 3;     // Signal open filter time (0-31)
INPUT int Indicator_SignalOpenBoostMethod = 0;    // Signal open boost method
INPUT int Indicator_SignalCloseMethod = 0;        // Signal close method
INPUT int Indicator_SignalCloseFilter = 32;       // Signal close filter (-127-127)
INPUT float Indicator_SignalCloseLevel = 0;       // Signal close level
INPUT int Indicator_PriceStopMethod = 0;          // Price limit method
INPUT float Indicator_PriceStopLevel = 2;         // Price limit level
INPUT int Indicator_TickFilterMethod = 32;        // Tick filter method (0-255)
INPUT float Indicator_MaxSpread = 4.0;            // Max spread to trade (in pips)
INPUT short Indicator_Shift = 0;                  // Shift
INPUT float Indicator_OrderCloseLoss = 80;        // Order close loss
INPUT float Indicator_OrderCloseProfit = 80;      // Order close profit
INPUT int Indicator_OrderCloseTime = -30;         // Order close time in mins (>0) or bars (<0)
INPUT_GROUP("Indicator strategy: Indicator indicator params");
INPUT ENUM_INDICATOR_TYPE Indicator_Indi_Indicator_Type = INDI_NONE;                 // Indicator type
INPUT int Indicator_Indi_Indicator_Shift = 0;                                        // Shift
INPUT ENUM_IDATA_SOURCE_TYPE Indicator_Indi_Indicator_SourceType = IDATA_INDICATOR;  // Source type

// Structs.

// Defines struct with default user strategy values.
struct Stg_Indicator_Params_Defaults : StgParams {
  Stg_Indicator_Params_Defaults()
      : StgParams(::Indicator_SignalOpenMethod, ::Indicator_SignalOpenFilterMethod, ::Indicator_SignalOpenLevel,
                  ::Indicator_SignalOpenBoostMethod, ::Indicator_SignalCloseMethod, ::Indicator_SignalCloseFilter,
                  ::Indicator_SignalCloseLevel, ::Indicator_PriceStopMethod, ::Indicator_PriceStopLevel,
                  ::Indicator_TickFilterMethod, ::Indicator_MaxSpread, ::Indicator_Shift) {
    Set(STRAT_PARAM_LS, Indicator_LotSize);
    Set(STRAT_PARAM_OCL, Indicator_OrderCloseLoss);
    Set(STRAT_PARAM_OCP, Indicator_OrderCloseProfit);
    Set(STRAT_PARAM_OCT, Indicator_OrderCloseTime);
    Set(STRAT_PARAM_SOFT, Indicator_SignalOpenFilterTime);
  }
};

class Stg_Indicator : public Strategy {
 public:
  Stg_Indicator(StgParams &_sparams, TradeParams &_tparams, ChartParams &_cparams, string _name = "")
      : Strategy(_sparams, _tparams, _cparams, _name) {}

  static Stg_Indicator *Init(ENUM_TIMEFRAMES _tf = NULL) {
    // Initialize strategy initial values.
    Stg_Indicator_Params_Defaults stg_indi_defaults;
    StgParams _stg_params(stg_indi_defaults);
    // Initialize indicator.
    // Initialize Strategy instance.
    ChartParams _cparams(_tf, _Symbol);
    TradeParams _tparams;
    Strategy *_strat = new Stg_Indicator(_stg_params, _tparams, _cparams, "Indicator");
    return _strat;
  }

  /**
   * Event on strategy's init.
   */
  void OnInit() {
    /*
    IndiIndicatorParams _indi_params(::Indicator_Indi_Indicator_Shift);
    _indi_params.SetTf(Get<ENUM_TIMEFRAMES>(STRAT_PARAM_TF));
    SetIndicator(new Indi_Indicator(_indi_params));
    */
  }

  /**
   * Check strategy's opening signal.
   */
  bool SignalOpen(ENUM_ORDER_TYPE _cmd, int _method, float _level = 0.0f, int _shift = 0) {
    IndicatorBase *_indi = GetIndicator();
    bool _result = true;
    if (!_result) {
      // Returns false when indicator data is not valid.
      return false;
    }
    IndicatorSignal _signals = _indi.GetSignals(4, _shift);
    switch (_cmd) {
      case ORDER_TYPE_BUY:
        // Buy signal.
        //_result &= _indi.IsIncreasing(1, 0, _shift);
        //_result &= _indi.IsIncByPct(_level / 10, 0, _shift, 2);
        //_result &= _method > 0 ? _signals.CheckSignals(_method) : _signals.CheckSignalsAll(-_method);
        break;
      case ORDER_TYPE_SELL:
        // Sell signal.
        //_result &= _indi.IsDecreasing(1, 0, _shift);
        //_result &= _indi.IsDecByPct(_level / 10, 0, _shift, 2);
        //_result &= _method > 0 ? _signals.CheckSignals(_method) : _signals.CheckSignalsAll(-_method);
        break;
    }
    return _result;
  }
};
