#line 1 "C:/Users/Mufaddal Darbar/Desktop/Project dumps/mikroc/pwmongpio/pwmongpio.c"
long Ton;
long Toff;
long long tmrvalue1;
long long tmrvalue2;
char state;
char txt[4];
char txt1[13];
long value;
int i;
sbit lcd_rs at rc0_bit;
sbit lcd_en at rc1_bit;
sbit lcd_d4 at rc2_bit;
sbit lcd_d5 at rc3_bit;
sbit lcd_d6 at rc4_bit;
sbit lcd_d7 at rc5_bit;

sbit lcd_rs_direction at trisc0_bit;
sbit lcd_en_direction at trisc1_bit;
sbit lcd_d4_direction at trisc2_bit;
sbit lcd_d5_direction at trisc3_bit;
sbit lcd_d6_direction at trisc4_bit;
sbit lcd_d7_direction at trisc5_bit;
void maininit();
void interrupt()
{
if (tmr1if_bit){state=1-state;
if (state)
{

Ton=i;
tmrvalue1=65536- Ton;
tmr1h=tmrvalue1>>8; tmr1l=tmrvalue1&0x00ff;
}

 else{

Toff=1000-Ton;
tmrvalue2=65536-Toff;
tmr1h=tmrvalue2>>8; tmr1l=tmrvalue2&0x00ff;
}


tmr1if_bit=0;
 }
}


void main() {
maininit();
i=0;state=0;
lcd_out(1,1,"Dutycycle=");
while(1)
{
portb.rb0=state;
value=ADC_read(2);
value=(value*100);
value*=10;
value/=1024;
i=(int)value;
inttostr(i/10,txt);
lcd_out(1,11,txt);


}

}

void maininit()
{
chs0_bit=0;
chs1_bit=1;
chs2_bit=0;
adcon1=0x00;
trisa=0xff;
trisb.rb0=0;
ADC_init();
GIE_bit=1;
peie_bit=1;
t1con=0x01;
tmr1ie_bit=1;
tmr1if_bit=0;
lcd_init();
lcd_cmd(_lcd_clear);
lcd_cmd(_lcd_cursor_off);
tmr1h=0xff; tmr1l=0x0c;
}
