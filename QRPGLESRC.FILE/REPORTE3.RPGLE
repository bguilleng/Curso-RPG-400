000100201212     FSIMEMPPF  IF   E             DISK
000200201212     FRLU123    O    E             PRINTER OFLIND (*IN99)
000300201212     C                   MOVE      *ON           *IN99
000400201212     C                   WRITE     RCD001
000500201212     C                   WRITE     RCD003
000600201212     C                   MOVE      *Off          *IN99
000700201212     C                   READ      SIMEMPPF
000800201212     C                   DOW       NOT %EOF(SIMEMPPF)
000900201212      *
001000201212     C                   WRITE     RCD002
001100201212      *
001200201212     C     *IN99         IFEQ      *ON
001300201212     C                   WRITE     RCD001
001400201212     C                   WRITE     RCD003
001500201212     C                   ENDIF
001600201212     C                   READ      SIMEMPPF
001700201212     C                   ENDDO
001800201212     C                   SETON                                        LR
001900201212     C                   RETURN
