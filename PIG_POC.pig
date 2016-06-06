DailyStocks = LOAD '/input/sp500hst.txt' using PigStorage(',') AS ( date:chararray, stocksymbol:chararray, dayopen:double, dayhigh:double, daylow:double, dayclose:double, volume:long);
DailyPrices_grouped = GROUP DailyStocks by stocksymbol;
DailyPrices_highlows = FOREACH DailyPrices_grouped GENERATE group, MAX(DailyStocks.dayhigh), MIN(DailyStocks.daylow), MAX(DailyStocks.dayhigh) - MIN(DailyStocks.daylow);
DailyPrices_highlows_sorted = ORDER DailyPrices_highlows BY $3 DESC;
DailyPrices_highlows_top10 = LIMIT DailyPrices_highlows_sorted 10;
STORE DailyPrices_highlows_top10 INTO '/output/pigStockTopTen';
STORE DailyPrices_highlows INTO '/output/pigStock';
