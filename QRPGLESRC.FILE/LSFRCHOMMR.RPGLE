000100201212     H  Option(*NoDebugIo:*SrcStmt)
000101201212     H  Debug( *Yes )
000102201212     H COPYRIGHT('COPYRIGHT 2020 xxxxxxx .ALL RIGHTS RESERVED')
000103201212     ß*
000104201212     À* "COPYRIGHT 2020 xxxxxxx. ALL RIGHTS RESERVED"
000105201212     À* CORE          : xxxxxxxxx
000106201212     À* PROGRAMA      : LSFRCHOMMR
000107201212     À* DESCRIPCIàN   : Mantenimiento c•digos decretos leasing
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
000119201212     À*
000120201212     ß*               DEFINICIONES DE ARCHIVOS
000121201212     À* Archivo Cuentas Contables
000122201212     FLSFRCHOMF UF A E           K disk
000123201212     À* Pantalla de parametrizaci¢n
000124201212     FLSFRCHOMMDCF   E             workstn
000125201212     F                                     Indds(Indica)
000126201212      *
000127201212     À* Declaraci•n prototipo programa mantenimiento
000128201212     D MTOPLNR         PR                  ExtPgm('LSFRCHOMMR')
000129201212     D opc                            1
000130201212     D decreto                        6  0
000131201212     D error                          1  0
000132201212      *
000133201212
000134201212     À* Declaraci•n de la interface
000135201212     D MTOPLNR         PI
000136201212     D wopc                           1
000137201212     D wdecreto                       6  0
000138201212     D werror                         1  0
000139201212
000140201212     À* Area de Indicadores
000141201212     D Indica          Ds
000142201212     D Aceptar                         n   overlay(Indica:02)
000143201212     D Salir                           n   overlay(Indica:03)
000144201212     D Protect                         n   overlay(Indica:11)
000145201212     D Cancela                         n   overlay(Indica:12)
000146201212
000147201212     À* Descripci¢n de DDS de prorama
000148201212     D                SDS
000149201212     D  SYSPGM                 1     10
000150201212     D  SYSJOB               244    253
000151201212     D  USUARI               254    263
000152201212     D  SYSCEN               264    273
000153201212     D  SYSANO               274    275  0
000154201212     D  SYSMES               276    277  0
000155201212     D  SYSDIA               278    279  0
000156201212     D  SYSHOR               282    287  0
000157201212     D  WFPGM                  1     10
000158201212
000159201212     À* Variables del proceso
000160201212     À* TimeStamp
000161201212     D  SysFecDat      S               Z   INZ(*sys)
000162201212     D  WPlnEdo        S                   like(FRCEDO)
000163201212     D  WEstadoI       S             10
000164201212     D  WEstadoF       S             10
000165201212     D  SwBack         s               n
000166201212     D  IndMod         s               n
000167201212     D  WPln           s              5
000168201212     D  vEdo           s              1
000169201212
000170201212     À* Constantes
000171201212     D  WMsgCamv       C                   'Campos deben tener valores v lidos!'
000172201212     D  WMsgRegE       C                   'Registro ya existe...!'
000173201212     D  WFunC          C                   'Crear Homologaci•n Decreto Frech'
000174201212     D  WFunCon        C                   'Consultar Homologaci•n Decreto Frec-
000175201212     D                                     h'
000176201212     D  WFunM          C                   'Modificar Homologaci•n Decreto Frec-
000177201212     D                                     h'
000178201212     D  WMsgNew        C                   'Registro Creado....!'
000179201212     D  WMsgMod        C                   'Registro Modificado....!'
000180201212      *
000181201212      /Free
000182201212
000183201212     ß*               INICIO DEL PROGRAMA
000184201212        Dow Not Cancela;
000185201212            write dummy;
000186201212            If wOpc<>'0' and wDecreto<>0 and wOpc<>'6';
000187201212               If wOpc='2' Or wOpc='4' Or wOpc='5' Or wOpc='3';
000188201212                  SetLl (WDecreto) LSFRCHOMF;
000189201212                  If %Equal(LSFRCHOMF);
000190201212                      ReadE (wDecreto) LSFRCHOMF;
000191201212                      wError=0;
000192201212                  Else;
000193201212                      wError=1;
000194201212                      Cancela='1';
000195201212                  EndIf;
000196201212               Else;
000197201212                  wError=0;
000198201212               EndIf;
000199201212
000200201212               If wError=0;
000201201212                  Select;
000202201212                    When wOpc='2';
000203201212                         ExSr SbrMod;
000204201212                    When wOpc='3';
000205201212                         ExSr SbrCons;
000206201212                    When wOpc='5';
000207201212                         wPlnEdo=0;
000208201212                         ExSr SbrAict;
000209201212                    When wOpc='4';
000210201212                         wPlnEdo=1;
000211201212                         ExSr SbrAict;
000212201212                  EndSl;
000213201212               EndIf;
000214201212            Else;
000215201212               If wOpc='6';
000216201212                  ExSr SbrNew;
000217201212               Else;
000218201212                  wError=7;
000219201212                  Cancela='1';
000220201212               EndIf;
000221201212            EndIf;
000222201212        EndDo;
000223201212        *InLr=*On;
000224201212
000225201212     ß*               CREAR NUEVO REGISTRO
000226201212        BegSr SbrNew;
000227201212              Dow Not Cancela;
000228201212                  TFuncion=WFunC;
000229201212                  ExFmt Win001;
000230201212                  Msg001=*Blanks;
000231201212                  //Valida campos
000232201212                  ExSr SbrVal;
000233201212
000234201212                  //F2-Confirmar
000235201212                  If Aceptar;
000236201212                     SetLl (WFRCCODL) LSFRCHOMF;
000237201212                     If %Equal(LSFRCHOMF);
000238201212                        Msg001=WMsgRegE;
000239201212                     Else;
000240201212                        FRCCODL = WFRCCODL;
000241201212                        FRCCODF = WFRCCODF;
000242201212                        FRCDESC = WFRCDESC;
000243201212                        FRCEDO  = 0;
000244201212                        FRCFCRE = %Dec(%Date():*EUR);
000245201212                        FRCHCRE = %Dec(%Time():*ISO);
000246201212                        FRCUCRE = Usuari;
000247201212                        Write LSFRCHD;
000248201212
000249201212                        Cancela='1';
000250201212                     EndIf;
000251201212                  EndIf;
000252201212              EndDo;
000253201212        EndSr;
000254201212
000255201212     ß*               MODIFICAR REGISTRO
000256201212        BegSr SbrMod;
000257201212              wFRCCODL = FRCCODL;
000258201212              wFRCCODF = FRCCODF;
000259201212              wFRCDESC = FRCDESC;
000260201212              Dow Not Cancela;
000261201212                  TFuncion=WFunM;
000262201212                  ExFmt Win001;
000263201212                  Msg001=*Blanks;
000264201212                  //Valida campos
000265201212                  ExSr SbrVal;
000266201212
000267201212                  //F2-Confirmar
000268201212                  If Aceptar;
000269201212                     FRCCODL = WFRCCODL;
000270201212                     FRCCODF = WFRCCODF;
000271201212                     FRCDESC = WFRCDESC;
000272201212                     FRCMDOF = %Dec(%Date():*EUR);
000273201212                     FRCMUSE = Usuari;
000274201212                     update LSFRCHD;
000275201212                     Cancela='1';
000276201212                  EndIf;
000277201212              EndDo;
000278201212        EndSr;
000279201212
000280201212     ß*               CONSULTAR REGISTRO
000281201212        BegSr SbrCons;
000282201212              Dow Not Cancela;
000283201212                  If FRCEDO = 0;
000284201212                     wEstd = 'Activo';
000285201212                  Else;
000286201212                     wEstd = 'Inactivo';
000287201212                  EndIf;
000288201212                  TFuncion=WFunCon;
000289201212                  ExFmt Win002;
000290201212              EndDo;
000291201212        EndSr;
000292201212
000293201212     ß*               VALIDA CAMPOS
000294201212        BegSr SbrVal;
000295201212              //Valida campos de entrada
000296201212              If (WFRCCODL=0 Or WFRCCODL=0 Or WFRCDESC=*Blanks)
000297201212                  and Not Cancela;
000298201212                 Msg001=WMsgCamv;
000299201212              EndIf;
000300201212        EndSr;
000301201212
000302201212     ß*               INACTIVA REGISTRO
000303201212        BegSr SbrAict;
000304201212              If FRCEDO=WPlnEdo;
000305201212                 If WPlnEdo=0;
000306201212                    //Ya est… activo
000307201212                    WError=2;
000308201212                    Cancela='1';
000309201212                 Else;
000310201212                    //Ya est… inactivo
000311201212                    WError=3;
000312201212                    Cancela='1';
000313201212                 EndIf;
000314201212              Else;
000315201212                 FRCEDO=WPlnEdo;
000316201212
000317201212                 If WPlnEdo=0;
000318201212                    //Activado
000319201212                    WError=4;
000320201212                    WEstadoI='Inactivo';
000321201212                    WEstadoF='Activo';
000322201212                    Cancela='1';
000323201212                 Else;
000324201212                    //Inactivado
000325201212                    WError=5;
000326201212                    WEstadoI='Activo';
000327201212                    WEstadoF='inactivo';
000328201212                    Cancela='1';
000329201212                 EndIf;
000330201212
000331201212                 FRCFINA=%Dec(%Date():*EUR);
000332201212                 FRCUINA=Usuari;
000333201212                 Update LSFRCHD;
000334201212              EndIf;
000335201212        Endsr;
000336201212
000337201212     ß*               RUTINA INCIALIZACION
000338201212        Begsr *Inzsr;
000339201212              title='MANTENIMIENTO HOMOLOGACION DECRETOS FRECH';
000340201212              title2='CONSULTA HOMOLOGACION DECRETOS FRECH';
000341201212        Endsr;
000342201212      /End-Free
000343201212
