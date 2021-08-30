000100201217     h option(*nodebugio) bnddir('MATHDIR')
000101201217     h actgrp('cursorpg')
000102201217
000103201217      /copy *libl/qrpglesrc,mathpr
000104201217
000105201217     d $num1           s             15s 2 inz(20)
000106201217     d $num2           s             15s 2 inz(2)
000107201217     d result          s             15s 2
000108201217
000109201217     c                   eval      result = Add($num1:$num2)
000110201217     c     result        dsply
000111201217
000112201217     c                   eval      result = Substract($num1:$num2)
000113201217     c     result        dsply
000114201217
000115201217     c                   eval      result = Multiply($num1:$num2)
000116201217     c     result        dsply
000117201217
000118201217     c                   eval      result = Divide($num1:$num2)
000119201217     c     result        dsply
000120201217
000121201217     c                   eval      *inlr = *on
