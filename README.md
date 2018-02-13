# The project is a music game named "rhyme master" which can be operated on Xilinx.
# Platform
EDA tool: ise design suite 14.7
demoboard model: Spartan6 XC6LX16-CS324
FPGA model: Xilinx
# Peripherals
buzzer
# Introductions
- Place the demoboard horizontally, the rightmost line is the tapping line. With the playing of music, the light key well move toward you (to right) until the tapping line. While they are just on the tapping line, press the button of demoboard.
- the pathway is like this
```
-----------------
|		|		|		|key is moving on the screen in this direction
|d 		|		|a 		↓
-----------------		↓
   b         c 			↓
-----------------		↓
|		|		|		↓
| 		|		|		↓
-----------------		↓
-----------------		↓
|		|		|		↓
|		|		|		↓
-----------------		↓
-----------------		↓
|		|		|		↓
| 		|		|		↓
-----------------	<--tapping line
```
- there are four pathways. On "a" and "d" there are only long keys which means you should press the button for longer. On "b" and "c" you should press for shorter. And there are broken line keys like "L" which means you should press "d" and "b" at the same time while they are on the tapping line.
- there are three qualities for your pressing. If the distance between the time key's appearing on tapping line and your pressing is not more than 0.1s, your time prediction and pressing is "perfect" which praise you 50 marks. The distance which is more than 0.1s but not more than 3 timeunits is "great" which praise you 25 marks. If you press later than the apprearing time then you get a "miss". You can end pressing a long key ahead of time. If that the score you get is calculated according to the time ratio you press.
- Your current pressing ranking is presented real-time on the first three led lights. Perfect means 3 lights on, great means 2 and miss means one.
- Your whole score is presented real-time on the last five led lights. Initially you have 0 score and no lights on. If you get not more than 100 scores you have one on, 300 scores you will have two, 700 scores you will have 4, and 1000 means 4, 2000 means 5 which is difficult because the whole score is not more than 2500.
- there are 4 switches for ajusting modes. Turn on the Switch 0 means low speed, Switch 1 means medium, Switch 2 means fast. Other switch situation means "horrible"! The function of last switch is pause. The music is suspended as well as the key. You can continue by reswitch the last switch.