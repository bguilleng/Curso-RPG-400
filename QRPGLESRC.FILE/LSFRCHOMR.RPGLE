000100201212     H  Option(*NoDebugIo:*SrcStmt)
000101201212     H  Debug( *Yes )
000102201212     H COPYRIGHT('COPYRIGHT 2020 XXXXXXXXXXXXXX. ALL RIGHTS RESERVED')
000103201212     ß*
000104201212     À* "COPYRIGHT 2020 XXXXXXXXXXXXX. ALL RIGHTS RESERVED"
000105201212     À* CORE          : xxxxxxxxxx
000106201212     À* PROGRAMA      : LSFRCHOMR
000107201212     À* DESCRIPCIàN   : Parametrizaci¢n Homologacion Decreto
000108201212     À* AUTOR         : Giovanny Guillen
000109201212     À* FECHA CREA.   :
000110201212     ¼* VERSION       : 1.0
000111201212     ß*               BITACORA DE CAMBIOS
000112201212     Î* Nro Solicitud :
000113201212     Î* Solicitado por:
000114201212     Î* Realizado por :
000115201212     Î* Descripci•n   :
000116201212     Î* Fecha Cambio  :
000117201212     Î* Versi•n       :
000118201212     ß*               DEFINICIONES DE COMPILACIãN
000119201212     À* Archivo Homologacion Decreto
000120201212     FLSFRCHOMF IF   E           K disk
000121201212     À* Pantalla de parametrizaci¢n
000122201212     FLSFRCHOMD CF   E             workstn SFILE(SFL001:RRN01)
000123201212     F                                     Indds(Indica)
000124201212      *
000125201212     À* Declaraci•n prototipo programa
000126201212     D CTAPLNR         PR                  ExtPgm('LSFRCHOMR')
000127201212      *
000128201212
000129201212     À* Declaraci•n de la interface
000130201212     D CTAPLNR         PI
000131201212
000132201212     À* Declaraci¢n prototipo programa mantenimiento
000133201212     D MtoPgm          PR                  ExtPgm('LSFRCHOMMR')
000134201212     D Opc                            1
000135201212     D Decreto                        6  0
000136201212     D Error                          1  0
000137201212
000138201212     À* Area de Indicadores
000139201212     D Indica          Ds
000140201212     D Aceptar                         n   overlay(Indica:02)
000141201212     D Salir                           n   overlay(Indica:03)
000142201212     D Nuevo                           n   overlay(Indica:06)
000143201212     D Protect                         n   overlay(Indica:11)
000144201212     D SDsp                            n   overlay(Indica:55)
000145201212     D SLim                            n   overlay(Indica:56)
000146201212     D Err_Lim                         n   overlay(Indica:38)
000147201212     D Avanza                          n   overlay(Indica:35)
000148201212     D Atras                           n   overlay(Indica:36)
000149201212
000150201212     À* Descripci¢n de DDS de prorama
000151201212     D                SDS
000152201212     D  SYSPGM                 1     10
000153201212     D  SYSJOB               244    253
000154201212     D  USUARI               254    263
000155201212     D  SYSCEN               264    273
000156201212     D  SYSANO               274    275  0
000157201212     D  SYSMES               276    277  0
000158201212     D  SYSDIA               278    279  0
000159201212     D  SYSHOR               282    287  0
000160201212     D  WFPGM                  1     10
000161201212
000162201212     À* Variables del proceso
000163201212     À* Registro por subfile
000164201212     D  W@SFLSIZ       s              5  0 INZ(9)
000165201212     À* Contador Registro
000166201212     D  W@CONT         s              5  0 INZ(0)
000167201212     À* Lnea
000168201212     D  W@LIN          s              5  0 INZ(0)
000169201212     À* TimeStamp
000170201212     D  SysFecDat      S               Z   INZ(*sys)
000171201212     D  WPlnEdo        S                   like(FRCEDO)
000172201212     D  WPlnNro        S                   like(FRCCODL)
000173201212     D  SwBack         s               n
000174201212     D  IndLlena       s               n
000175201212     D  WPln           s              5
000176201212     D  vEdo           s              1  0
000177201212
000178201212     À* Constantes
000179201212     D  WMsgRegE       C                   'C•digo ya existe...!'
000180201212     D  WMsgRegM       C                   'C•digo no existe...!'
000181201212     D  WMsgRac        C                   'Registro est  inactivo, debe activa-
000182201212     D                                     rlo...!'
000183201212     D  WMsgInac       C                   'Registro ya est  inactivo, no se pu-
000184201212     D                                     ede inactivar de nuevo...!'
000185201212     D  WMsgActv       C                   'Registro ya est  activo, no se pued-
000186201212     D                                     e activar de nuevo...!'
000187201212      *
000188201212      /Free
000189201212
000190201212     ß*               INICIO DEL PROGRAMA
000191201212        Dow Not Salir;
000192201212            ExSr SbrClr;
000193201212            //Llenar Subfile
000194201212            SELEC=1;
000195201212            SetLl *Start LSFRCHOMF;
000196201212            EXSR SbrLodSfl;
000197201212            IF RRN01=*ZEROS;
000198201212               SDsp='0';
000199201212            Else;
000200201212               SDsp='1';
000201201212            ENDIF;
000202201212            //Procesa inf.Pantalla
000203201212            Dow Not Salir;
000204201212                EXSR SbrPrcW;
000205201212            EndDo;
000206201212        EndDo;
000207201212        *InLr=*On;
000208201212
000209201212     ß*               CARGA SUBFILE
000210201212        BegSr SbrLodSfl;
000211201212              If SwBack;
000212201212                 SetLl FRCCODL LSFRCHOMF;
000213201212                 SwBack='0';
000214201212              EndIf;
000215201212              IndLlena='0';
000216201212              Rrn01=0;
000217201212              Read LSFRCHOMF;
000218201212              WPlnNro=FRCCODL;
000219201212              DoW  not %eof(LSFRCHOMF);
000220201212                   SelecT;
000221201212                     When selec=1;
000222201212                          ExSr SbrLlena;
000223201212                          If IndLlena;
000224201212                             Leave;
000225201212                          EndIf;
000226201212                     When selec=2 and FRCEDO=0;
000227201212                          ExSr SbrLlena;
000228201212                          If IndLlena;
000229201212                             Leave;
000230201212                          EndIf;
000231201212                     When selec=3 and FRCEDO=1;
000232201212                          ExSr SbrLlena;
000233201212                          If IndLlena;
000234201212                             Leave;
000235201212                          EndIf;
000236201212                   EndSl;
000237201212                   Read LSFRCHOMF;
000238201212              EndDo;
000239201212
000240201212              IF RRN01=*ZEROS;
000241201212                 SDsp='0';
000242201212              Else;
000243201212                 SDsp='1';
000244201212              ENDIF;
000245201212
000246201212        EndSr;
000247201212
000248201212     ß*               LLENA SUBFILE
000249201212        BegSr SbrLlena;
000250201212              Rrn01+=1;
000251201212              ExSr SbrCarg;
000252201212              WRITE SFL001;
000253201212              IF RRN01=W@SFLSIZ;
000254201212                 IndLlena='1';
000255201212              ENDIF;
000256201212        EndSr;
000257201212
000258201212     ß*               PROCESA INFORMACIãN PANTALLA
000259201212        BegSr SbrPrcW;
000260201212             WRITE DSP001;
000261201212             ExFmt CTL001;
000262201212             ERRORSBF=*Blanks;
000263201212
000264201212             If SDsp='1';
000265201212             //Lee subfile
000266201212               ReadC Sfl001;
000267201212               vEdo=0;
000268201212               Select;
000269201212               When Opc='2';
000270201212                    //Modificar;
000271201212                    If FRCEDO=1;
000272201212                       ERRORSBF=WmsgRac;
000273201212                    Else;
000274201212                       MtoPgm(Opc:FRCCODL:vEdo);
000275201212                    EndIf;
000276201212               When Opc='3';
000277201212                    //Consultar;
000278201212                    MtoPgm(Opc:FRCCODL:vEdo);
000279201212               When Opc='4';
000280201212                    //Inactivar;
000281201212                    If FRCEDO  =1;
000282201212                       ERRORSBF=WmsgInac;
000283201212                    Else;
000284201212                       MtoPgm(Opc:FRCCODL:vEdo);
000285201212                    EndIf;
000286201212               When Opc='5';
000287201212                    //Activar;
000288201212                    If FRCEDO  =0;
000289201212                       ERRORSBF=WmsgActv;
000290201212                    Else;
000291201212                       MtoPgm(Opc:FRCCODL:vEdo);
000292201212                    EndIf;
000293201212               When Nuevo;
000294201212                    Opc='6';
000295201212                    //Crear;
000296201212                    FRCCODL=0;
000297201212                    MtoPgm(Opc:FRCCODL:vEdo);
000298201212               EndSl;
000299201212             Else;
000300201212               If Nuevo;
000301201212                  Opc='6';
000302201212                  //Crear;
000303201212                  FRCCODL=0;
000304201212                  MtoPgm(Opc:FRCCODL:vEdo);
000305201212               EndIf;
000306201212             EndIf;
000307201212
000308201212             //Valida Tecla de Funci•n
000309201212             Select;
000310201212               WHEN Salir;
000311201212                    LeaveSr;
000312201212               WHEN Selec>0 And Not Avanza And Not Atras
000313201212                    And CODCRE =0 And Opc=' ';
000314201212                    ExSr SbrClr;
000315201212                    SetLl *Start LSFRCHOMF;
000316201212                    EXSR SbrLodSfl;
000317201212               WHEN Avanza='1';
000318201212                    EXSR SBRNext;
000319201212               WHEN Atras='1';
000320201212                    EXSR SBRBack;
000321201212               WHEN CODCRE >0;
000322201212                    ExSr SbrBPln;
000323201212             ENDSL;
000324201212
000325201212             If Opc <> *Blanks;
000326201212                 Clear Opc;
000327201212                 ExSr SbrClr;
000328201212               //******** Llenar Subfile ********
000329201212                 SetLl *Start LSFRCHOMF;
000330201212                 EXSR SbrLodSfl;
000331201212                 Opc =  *Blanks;
000332201212             EndIf;
000333201212        ENDSR;
000334201212
000335201212     ß*               SITUAR EN
000336201212        BegSr SbrBPln;
000337201212              ExSr SbrClr;
000338201212              SetLL CODCRE  LSFRCHOMF;
000339201212              Read LSFRCHOMF;
000340201212              DOW NOT %EOF(LSFRCHOMF);
000341201212                  Rrn01+=1;
000342201212                  ExSr SbrCarg;
000343201212                  WRITE SFL001;
000344201212                  IF Rrn01 >= W@SFLSIZ;
000345201212                     LEAVE;
000346201212                  ENDIF;
000347201212                  Read LSFRCHOMF;
000348201212              ENDDO;
000349201212
000350201212              IF RRN01>*ZEROS;
000351201212                 SDsp='1';
000352201212              ENDIF;
000353201212        EndSr;
000354201212
000355201212     ß*               AVANZAR PAGINA
000356201212        BegSr SbrNext;
000357201212              ExSr SbrClr;
000358201212              ExSr SbrLodSfl;
000359201212        EndSr;
000360201212
000361201212     ß*               RETROCEDE
000362201212        BegSr SbrBack;
000363201212              FRCCODL=WPlnNro;
000364201212              Rrn01=0;
000365201212              SetGt FRCCODL LSFRCHOMF;
000366201212              ReadPe FRCCODL LSFRCHOMF;
000367201212              DOW NOT %EOF(LSFRCHOMF);
000368201212                  Rrn01+=1;
000369201212                  IF Rrn01 >= W@SFLSIZ;
000370201212                     ReadP LSFRCHOMF;
000371201212                     LEAVE;
000372201212                  ENDIF;
000373201212                  ReadP LSFRCHOMF;
000374201212              ENDDO;
000375201212              Rrn01=0;
000376201212              SwBack='1';
000377201212              ExSr SbrNext;
000378201212        EndSr;
000379201212
000380201212     ß*               CARGA DATOS
000381201212        BegSr SbrCarg;
000382201212              //Determina estado registro
000383201212              If FRCEDO  =1;
000384201212                 *In81='1';
000385201212                 *In80='0';
000386201212                 WEstado='Inactivo';
000387201212              Else;
000388201212                 *In81='0';
000389201212                 *In80='1';
000390201212                 WEstado='Activo';
000391201212              EndIf;
000392201212        EndSr;
000393201212
000394201212     ß*               LIMPIA SUBFILE
000395201212        BegSr SbrClr;
000396201212              Rrn01=0;
000397201212              Opc=*Blanks;
000398201212              SLim='1';
000399201212              WRITE Ctl001;
000400201212              SLim='0';
000401201212              SDsp='1';
000402201212        ENDSR;
000403201212
000404201212     ß*               RUTINA INCIALIZACION
000405201212        Begsr *Inzsr;
000406201212         PGM     =%Trim(SYSPGM);
000407201212         TProceso='PARAMETRIZACION HOMOLOGACION DECRETOS';
000408201212         TMODULO ='          FRECH LEASING              ';
000409201212         TBANCO  ='       XXXXXXXXXXXXXXXXXXX           ';
000410201212        Endsr;
000411201212      /End-Free
000412201212
