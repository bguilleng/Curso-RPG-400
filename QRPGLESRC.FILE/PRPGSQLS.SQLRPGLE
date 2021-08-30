000001201217     H DFTACTGRP(*NO)
000100201217     Fqsysprt   o    f  132        printer
000101201217
000102201217     D Customer        ds                  qualified inz
000103201217     D   Number                       6p 0
000104201217     D   LastName                    50a
000105201217     D   Initials                    10a
000106201217     D   City                        20a
000107201217     D   State                        1p 0
000108201217     D   BalanceDue                  15p 2
000109201217
000110201217     D SqlEof          c                   const('02000')
000111201217     D DetailLine      s            132a
000112201217
000113201217     D Print           pr
000114201217     D   Data                       132a   value
000115201217
000116201217      /free
000117201217       exec sql
000119201217            SET OPTION COMMIT = *NONE;
000120201217       exec sql
000121201217        declare Input cursor for
000122201217           select CUSNUM, LSTNAME, INIT, CITY, STATE, BALDUE
000123201217             from custcdt
000124201217            where baldue <> 0
000125201217            order by baldue desc
000126201217            FOR FETCH ONLY;
000127201217
000128201217       exec sql
000129201217        open Input;
000130201217       exec sql
000131201217        fetch NEXT FROM Input into :Customer;
000132201217
000133201217       dow sqlstt = '00000';
000137201217           Print (%editc(Customer.BalanceDue:'J') + ' ' +
000138201217               Customer.LastName + ' ' +
000139201217               Customer.Initials + ' ' +
000140201217               %editc(Customer.Number:'4') + ' ' +
000141201217               %trimr(Customer.City) + ', ' + %Char(Customer.State));
000142201217          exec sql
000143201217           fetch NEXT FROM Input into :Customer;
000145201217           if sqlstt >= SqlEof;
000146201217              leave;
000147201217           endif;
000148201217       enddo;
000149201217       exec sql
000150201217        close Input;
000151201217       *INLR='1';
000152201217      /end-free
000153201217
000154201217     Oqsysprt   e            PrintLine   1
000155201217     O                       DetailLine
000156201217      * ==========================================================
000157201217     P Print           b
000158201217     D                 pi
000159201217     D   Data                       132a   value
000160201217      /free
000161201217       DetailLine = Data;
000162201217       except PrintLine;
000163201217      /end-free
000164201217     P                 e
