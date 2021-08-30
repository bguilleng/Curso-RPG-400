000100201212     H  Option(*NoDebugIo:*SrcStmt)
000200201212     H  Debug( *Yes )
000300201212     H COPYRIGHT('COPYRIGHT 2020 XXXXXXXXXXXXXX. ALL RIGHTS RESERVED')
000400201212      *
000500201212      * "COPYRIGHT 2020 XXXXXXXXXXXXX. ALL RIGHTS RESERVED"
000600201212      * CORE          : xxxxxxxxxx
000700201212      * PROGRAMA      : LSFRCHOMR
000800201212      * DESCRIPCIàN   : Parametrizaci¢n Homologacion Decreto
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
002000201212      * Archivo Homologacion Decreto
002100201214     FSIMEMPPF  IF   E           K disk
002200201212      * Pantalla de parametrizaci¢n
002300201214     FSIMEMPSD  CF   E             workstn SFILE(SFL001:RRN01)
002400201212     F                                     Indds(Indica)
002500201212      *
002600201212      * Declaracin prototipo programa
002700201214     D CTAPLNR         PR                  ExtPgm('SIMEMPSRR')
002800201212      *
002900201212
003000201212      * Declaracin de la interface
003100201212     D CTAPLNR         PI
003800201212
003900201212      * Area de Indicadores
004000201212     D Indica          Ds
004200201212     D Salir                           n   overlay(Indica:03)
004201201214     D SDsp                            n   overlay(Indica:55)
004202201214     D SLim                            n   overlay(Indica:56)
005000201212
005100201212      * Descripci¢n de DDS de prorama
005200201212     D                SDS
005300201212     D  SYSPGM                 1     10
005400201212     D  SYSJOB               244    253
005500201212     D  USUARI               254    263
005600201212     D  SYSCEN               264    273
005700201212     D  SYSANO               274    275  0
005800201212     D  SYSMES               276    277  0
005900201212     D  SYSDIA               278    279  0
006000201212     D  SYSHOR               282    287  0
006100201212     D  WFPGM                  1     10
006200201212
006300201212      * Variables del proceso
007800201212
008900201212      /Free
009000201212
009100201212      *               INICIO DEL PROGRAMA
009200201212        Dow Not Salir;
009300201212            ExSr SbrClr;
009400201212            //Llenar Subfile
009600201214            SetLl *Start SIMEMPPF;
009700201212            EXSR SbrLodSfl;
009800201212            IF RRN01=*ZEROS;
009900201212               SDsp='0';
010000201212            Else;
010100201212               SDsp='1';
010200201212            ENDIF;
010201201214            Dow Not Salir;
010202201214                WRITE DSP001;
010203201214                ExFmt CTL001;
010204201214                If Salir;
010205201214                   Leave;
010206201214                EndIf;
010207201214            EndDo;
010700201212        EndDo;
010800201212        *InLr=*On;
010900201212
011000201212      *               CARGA SUBFILE
011100201212        BegSr SbrLodSfl;
011700201212              Rrn01=0;
011800201214              Read SIMEMPPF;
012000201214              DoW not %eof(SIMEMPPF);
012001201214                  Rrn01+=1;
012002201214                  WRITE SFL001;
012301201214                  Read SIMEMPPF;
013900201212              EndDo;
014000201212
014100201212              IF RRN01=*ZEROS;
014200201212                 SDsp='0';
014300201212              Else;
014400201212                 SDsp='1';
014500201212              ENDIF;
014600201212
014700201212        EndSr;
014800201212
029500201212      *               LIMPIA SUBFILE
029600201212        BegSr SbrClr;
029700201212              Rrn01=0;
029701201214              SLim='1';
030000201212              WRITE Ctl001;
030001201214              SLim='0';
030200201212              SDsp='1';
030300201212        ENDSR;
030400201212
030500201212      *               RUTINA INCIALIZACION
030600201212        Begsr *Inzsr;
030700201212         PGM     =%Trim(SYSPGM);
030800201214         TProceso='XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
030900201214         TMODULO ='          XXXXXXXXXXXXX              ';
031000201212         TBANCO  ='       XXXXXXXXXXXXXXXXXXX           ';
031100201212        Endsr;
031200201212      /End-Free
031300201212
