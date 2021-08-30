000100201212     H  Option(*NoDebugIo:*SrcStmt)
000200201212     H  Debug( *Yes )
000300201215     H COPYRIGHT('COPYRIGHT 2020 xxxxxxx             RESERVED')
000400201212      *
000500201212      * "COPYRIGHT 2020 xxxxxxx. ALL RIGHTS RESERVED"
000600201212      * CORE          : xxxxxxxxx
000700201214      * PROGRAMA      :
000800201214      * DESCRIPCIàN   :
000900201212      * AUTOR         : Giovanny Guillen
001000201212      * FECHA CREA.   :
001100201212      * VERSION       : 1.0
001200201212      *               BITACORA DE CAMBIOS
001300201212      * Nro Solicitud :
001400201212      * Solicitado por:
001500201212      * Realizado por :
001600201212      * Descripcin   :
001700201212      * Fecha Cambio  :
001800201212      * Versin       :
001900201212      *               DEFINICIONES DE COMPILACIãN
002000201212      *
002100201212      *               DEFINICIONES DE ARCHIVOS
002200201214      * Archivo Empleados
002300201214     FSIMEMPPF  UF A E           K disk
002400201214      * Pantalla de Mantenimiento empleados
002500201214     FSIMEMPPD  CF   E             workstn
002600201212     F                                     Indds(Indica)
002700201212      *
002800201212      * Declaracin prototipo programa mantenimiento
002900201214     D MTO             PR                  ExtPgm('SIMEMPPR')
003000201212      *
003100201212
003200201212      * Declaracin de la interface
003300201214     D MTO             PI
003400201212
003500201212      * Area de Indicadores
003600201212     D Indica          Ds
003700201214     D Grabar                          n   overlay(Indica:01)
003701201214     D Nuevo                           n   overlay(Indica:02)
003800201212     D Salir                           n   overlay(Indica:03)
003900201214     D Elimi                           n   overlay(Indica:05)
003901201214     D Modifi                          n   overlay(Indica:08)
003902201215     D Print                           n   overlay(Indica:09)
004000201215     D Cancea                          n   overlay(Indica:12)
004100201212
004200201212      * Descripci¢n de DDS de prorama
004300201212     D                SDS
004400201212     D  SYSPGM                 1     10
004500201212     D  SYSJOB               244    253
004600201212     D  USUARI               254    263
004700201212     D  SYSCEN               264    273
004800201212     D  SYSANO               274    275  0
004900201212     D  SYSMES               276    277  0
005000201212     D  SYSDIA               278    279  0
005100201212     D  SYSHOR               282    287  0
005200201212     D  WFPGM                  1     10
005300201212
005400201212      * Variables del proceso
005500201212      * TimeStamp
005600201212     D  SysFecDat      S               Z   INZ(*sys)
005601201214     D  Sw             S               n
006400201212
006500201212      * Constantes
006700201214     D  Mensa1         C                   'Registro ya existe...|'
006800201214     D  Mensa2         C                   'Debe indicar todos los valores'
006801201214     D  Mensa3         C                   'Registro Actualizado...|'
006802201214     D  Mensa4         C                   'Datos incompletos...|'
006803201214     D  Mensa5         C                   'Registro Eliminado...|'
007500201212      *
007600201212      /Free
007700201212
007800201212      *               INICIO DEL PROGRAMA
007900201215        Dow Not Cancea Or Not Salir;
007902201214            Write Panta01;
008000201214            ExFmt Panta01;
008001201214            Clear Mensaje;
008002201214            Select;
008003201214              When Nuevo;
008004201214                   ExSr SbrNew;
008005201214              When Elimi And Sw;
008006201214                   ExSr SbrDel;
008007201214              When Modifi And Sw;
008008201214                   ExSr SbrMod;
008009201215              When Cancea Or Salir;
008010201214                   Leave;
008011201214            EndSl;
008012201215            If Print;
008013201215               ExSr SBRImprimir;
008014201215            EndIf;
008015201215
008100201214            If EmpAdd<>0;
008200201214               Setll EmpAdd SIMEMPPF;
008300201214               If %Equal(Simemppf);
008301201214                  ReadE EmpAdd Simemppf;
008302201214                  Sw='1';
008303201214               Else;
008304201214                  Clear Panta01;
008305201214                  Sw='0';
008306201214               EndIf;
008307201214            EndIf;
008400201212        EndDo;
008500201212        *InLr=*On;
008600201212
008700201212      *               CREAR NUEVO REGISTRO
008800201212        BegSr SbrNew;
008801201214              Clear Panta02;
008900201215              Dow Not Cancea;
008901201214                  Write Panta02;
008902201214                  ExFmt Panta02;
008903201214                  Select;
008904201214                  When Grabar;
008905201214                     If EmpAdd<>0 And EmpName<>*Blanks
008906201214                        And EmpNum<>0 And EmpPh<>*Blanks;
008907201214                        Setll EmpAdd SIMEMPPF;
008908201214                        If Not %Equal(SIMEMPPF);
008909201214                           Write RSIMEMPP;
008910201215                           Cancea='1';
008911201214                        Else;
008912201214                           Mensaje = Mensa1;
008913201214                        EndIf;
008914201214                     Else;
008915201214                        Mensaje = Mensa2;
008916201214                     EndIf;
008917201215                  When Cancea;
008918201214                     LeaveSr;
008919201214                  EndSl;
009000201212              EndDo;
009100201212        EndSr;
009200201212
009300201212      *               MODIFICAR REGISTRO
009400201212        BegSr SbrMod;
009401201215              Dow Not Cancea;
009402201214                  Write Panta02;
009403201214                  ExFmt Panta02;
009404201214                  Select;
009405201214                  When Grabar;
009406201214                     If EmpAdd<>0 And EmpName<>*Blanks
009407201214                        And EmpNum<>0 And EmpPh<>*Blanks;
009410201214                        Update RSIMEMPP;
009411201215                        Cancea='1';
009413201214                        Mensaje = Mensa3;
009415201214                     Else;
009416201214                        Mensaje = Mensa4;
009417201214                     EndIf;
009418201215                  When Cancea;
009419201214                     LeaveSr;
009420201214                  EndSl;
009421201214              EndDo;
009500201212        EndSr;
009600201212
009700201214      *               ELIMINAR REGISTRO
009800201214        BegSr SbrDel;
009801201214              Delete RSIMEMPP;
009803201214              Mensaje = Mensa3;
010100201212        EndSr;
010101201215      *               IMPRIMIR
010102201215        BegSr SbrIMPRIMIR;
010103201215
010105201215        EndSr;
010200201212
010300201212      *               RUTINA INCIALIZACION
010400201212        Begsr *Inzsr;
010500201212        Endsr;
010600201212      /End-Free
010700201212
