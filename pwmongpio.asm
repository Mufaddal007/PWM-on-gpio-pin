
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;pwmongpio.c,24 :: 		void interrupt()
;pwmongpio.c,26 :: 		if (tmr1if_bit){state=1-state;
	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_interrupt0
	MOVF       _state+0, 0
	SUBLW      1
	MOVWF      _state+0
;pwmongpio.c,27 :: 		if (state)
	MOVF       _state+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt1
;pwmongpio.c,30 :: 		Ton=i;
	MOVF       _i+0, 0
	MOVWF      _Ton+0
	MOVF       _i+1, 0
	MOVWF      _Ton+1
	MOVLW      0
	BTFSC      _Ton+1, 7
	MOVLW      255
	MOVWF      _Ton+2
	MOVWF      _Ton+3
;pwmongpio.c,31 :: 		tmrvalue1=65536- Ton;
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      1
	MOVWF      R0+2
	MOVLW      0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      R5+0
	MOVF       R0+1, 0
	MOVWF      R5+1
	MOVF       R0+2, 0
	MOVWF      R5+2
	MOVF       R0+3, 0
	MOVWF      R5+3
	MOVF       _Ton+0, 0
	SUBWF      R5+0, 1
	MOVF       _Ton+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _Ton+1, 0
	SUBWF      R5+1, 1
	MOVF       _Ton+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _Ton+2, 0
	SUBWF      R5+2, 1
	MOVF       _Ton+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _Ton+3, 0
	SUBWF      R5+3, 1
	MOVF       R5+0, 0
	MOVWF      _tmrvalue1+0
	MOVF       R5+1, 0
	MOVWF      _tmrvalue1+1
	MOVF       R5+2, 0
	MOVWF      _tmrvalue1+2
	MOVF       R5+3, 0
	MOVWF      _tmrvalue1+3
;pwmongpio.c,32 :: 		tmr1h=tmrvalue1>>8;   tmr1l=tmrvalue1&0x00ff;
	MOVF       R5+1, 0
	MOVWF      R0+0
	MOVF       R5+2, 0
	MOVWF      R0+1
	MOVF       R5+3, 0
	MOVWF      R0+2
	MOVLW      0
	BTFSC      R5+3, 7
	MOVLW      255
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      TMR1H+0
	MOVLW      255
	ANDWF      R5+0, 0
	MOVWF      TMR1L+0
;pwmongpio.c,33 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;pwmongpio.c,37 :: 		Toff=1000-Ton;
	MOVLW      232
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       _Ton+0, 0
	SUBWF      R4+0, 1
	MOVF       _Ton+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _Ton+1, 0
	SUBWF      R4+1, 1
	MOVF       _Ton+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _Ton+2, 0
	SUBWF      R4+2, 1
	MOVF       _Ton+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _Ton+3, 0
	SUBWF      R4+3, 1
	MOVF       R4+0, 0
	MOVWF      _Toff+0
	MOVF       R4+1, 0
	MOVWF      _Toff+1
	MOVF       R4+2, 0
	MOVWF      _Toff+2
	MOVF       R4+3, 0
	MOVWF      _Toff+3
;pwmongpio.c,38 :: 		tmrvalue2=65536-Toff;
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      1
	MOVWF      R0+2
	MOVLW      0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      R8+0
	MOVF       R0+1, 0
	MOVWF      R8+1
	MOVF       R0+2, 0
	MOVWF      R8+2
	MOVF       R0+3, 0
	MOVWF      R8+3
	MOVF       R4+0, 0
	SUBWF      R8+0, 1
	MOVF       R4+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R4+1, 0
	SUBWF      R8+1, 1
	MOVF       R4+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R4+2, 0
	SUBWF      R8+2, 1
	MOVF       R4+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R4+3, 0
	SUBWF      R8+3, 1
	MOVF       R8+0, 0
	MOVWF      _tmrvalue2+0
	MOVF       R8+1, 0
	MOVWF      _tmrvalue2+1
	MOVF       R8+2, 0
	MOVWF      _tmrvalue2+2
	MOVF       R8+3, 0
	MOVWF      _tmrvalue2+3
;pwmongpio.c,39 :: 		tmr1h=tmrvalue2>>8;   tmr1l=tmrvalue2&0x00ff;
	MOVF       R8+1, 0
	MOVWF      R0+0
	MOVF       R8+2, 0
	MOVWF      R0+1
	MOVF       R8+3, 0
	MOVWF      R0+2
	MOVLW      0
	BTFSC      R8+3, 7
	MOVLW      255
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      TMR1H+0
	MOVLW      255
	ANDWF      R8+0, 0
	MOVWF      TMR1L+0
;pwmongpio.c,40 :: 		}
L_interrupt2:
;pwmongpio.c,43 :: 		tmr1if_bit=0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;pwmongpio.c,44 :: 		}
L_interrupt0:
;pwmongpio.c,45 :: 		}
L_end_interrupt:
L__interrupt6:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;pwmongpio.c,48 :: 		void main() {
;pwmongpio.c,49 :: 		maininit();
	CALL       _maininit+0
;pwmongpio.c,50 :: 		i=0;state=0;
	CLRF       _i+0
	CLRF       _i+1
	CLRF       _state+0
;pwmongpio.c,51 :: 		lcd_out(1,1,"Dutycycle=");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_pwmongpio+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;pwmongpio.c,52 :: 		while(1)
L_main3:
;pwmongpio.c,54 :: 		portb.rb0=state;
	BTFSC      _state+0, 0
	GOTO       L__main8
	BCF        PORTB+0, 0
	GOTO       L__main9
L__main8:
	BSF        PORTB+0, 0
L__main9:
;pwmongpio.c,55 :: 		value=ADC_read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
	CLRF       _value+2
	CLRF       _value+3
;pwmongpio.c,56 :: 		value=(value*100);
	MOVF       _value+0, 0
	MOVWF      R0+0
	MOVF       _value+1, 0
	MOVWF      R0+1
	MOVF       _value+2, 0
	MOVWF      R0+2
	MOVF       _value+3, 0
	MOVWF      R0+3
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
	MOVF       R0+2, 0
	MOVWF      _value+2
	MOVF       R0+3, 0
	MOVWF      _value+3
;pwmongpio.c,57 :: 		value*=10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
	MOVF       R0+2, 0
	MOVWF      _value+2
	MOVF       R0+3, 0
	MOVWF      _value+3
;pwmongpio.c,58 :: 		value/=1024;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      4
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
	MOVF       R0+2, 0
	MOVWF      _value+2
	MOVF       R0+3, 0
	MOVWF      _value+3
;pwmongpio.c,59 :: 		i=(int)value;
	MOVF       R0+0, 0
	MOVWF      _i+0
	MOVF       R0+1, 0
	MOVWF      _i+1
;pwmongpio.c,60 :: 		inttostr(i/10,txt);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;pwmongpio.c,61 :: 		lcd_out(1,11,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;pwmongpio.c,64 :: 		}
	GOTO       L_main3
;pwmongpio.c,66 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_maininit:

;pwmongpio.c,68 :: 		void maininit()
;pwmongpio.c,70 :: 		chs0_bit=0;
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
;pwmongpio.c,71 :: 		chs1_bit=1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;pwmongpio.c,72 :: 		chs2_bit=0;
	BCF        CHS2_bit+0, BitPos(CHS2_bit+0)
;pwmongpio.c,73 :: 		adcon1=0x00;
	CLRF       ADCON1+0
;pwmongpio.c,74 :: 		trisa=0xff;
	MOVLW      255
	MOVWF      TRISA+0
;pwmongpio.c,75 :: 		trisb.rb0=0;
	BCF        TRISB+0, 0
;pwmongpio.c,76 :: 		ADC_init();
	CALL       _ADC_Init+0
;pwmongpio.c,77 :: 		GIE_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;pwmongpio.c,78 :: 		peie_bit=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;pwmongpio.c,79 :: 		t1con=0x01;
	MOVLW      1
	MOVWF      T1CON+0
;pwmongpio.c,80 :: 		tmr1ie_bit=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;pwmongpio.c,81 :: 		tmr1if_bit=0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;pwmongpio.c,82 :: 		lcd_init();
	CALL       _Lcd_Init+0
;pwmongpio.c,83 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;pwmongpio.c,84 :: 		lcd_cmd(_lcd_cursor_off);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;pwmongpio.c,85 :: 		tmr1h=0xff; tmr1l=0x0c;
	MOVLW      255
	MOVWF      TMR1H+0
	MOVLW      12
	MOVWF      TMR1L+0
;pwmongpio.c,86 :: 		}
L_end_maininit:
	RETURN
; end of _maininit
