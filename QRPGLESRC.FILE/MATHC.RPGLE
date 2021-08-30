000100201217h nomain
000101201217
000102201217 /copy *libl/qrpglesrc,mathpr
000103201217
000104201217p Add             b                   export
000105201217d Add             PI            15s 2
000106201217d num1                          15s 2
000107201217d num2                          15s 2
000108201217
000109201217d result          s              6s 0
000110201217
000111201217 /free
000112201217          result = num1 + num2 ;
000113201217          return result;
000114201217 /end-free
000115201217p Add             e
000116201217
000117201217p Substract       b                   export
000118201217d Substract       PI            15s 2
000119201217d num1                          15s 2
000120201217d num2                          15s 2
000121201217
000122201217d result          s              6s 0
000123201217
000124201217 /free
000125201217          result = num1 - num2 ;
000126201217          return result;
000127201217 /end-free
000128201217p Substract       e
000129201217
000130201217p Multiply        b                   export
000131201217d Multiply        PI            15s 2
000132201217d num1                          15s 2
000133201217d num2                          15s 2
000134201217
000135201217d result          s              6s 0
000136201217
000137201217 /free
000138201217          result = num1 * num2 ;
000139201217          return result;
000140201217 /end-free
000141201217p Multiply        e
000142201217
000143201217p Divide          b                   export
000144201217d Divide          PI            15s 2
000145201217d num1                          15s 2
000146201217d num2                          15s 2
000147201217
000148201217d result          s              6s 0
000149201217
000150201217 /free
000151201217          result = num1 / num2 ;
000152201217          return result;
000153201217 /end-free
000154201217p Divide          e
