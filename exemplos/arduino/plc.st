TYPE
  LOGLEVEL : (CRITICAL, WARNING, INFO, DEBUG) := INFO;
END_TYPE

FUNCTION_BLOCK LOGGER
  VAR_INPUT
    TRIG : BOOL;
    MSG : STRING;
    LEVEL : LOGLEVEL := INFO;
  END_VAR
  VAR
    TRIG0 : BOOL;
  END_VAR

  IF TRIG AND NOT TRIG0 THEN
  {{
   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  }}
  END_IF;
  TRIG0:=TRIG;
END_FUNCTION_BLOCK


PROGRAM potenciometro
  VAR
    pot_valor AT %IW1 : UINT;
  END_VAR
  VAR
    ref : UINT := 32767;
  END_VAR
  VAR
    led_saida AT %QX0.3 : BOOL;
  END_VAR
  VAR
    _TMP_GT7_OUT : BOOL;
  END_VAR

  _TMP_GT7_OUT := GT(pot_valor, ref);
  led_saida := _TMP_GT7_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : potenciometro;
  END_RESOURCE
END_CONFIGURATION
