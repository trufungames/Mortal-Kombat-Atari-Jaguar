@echo off
echo ------------------------------------------------------------
echo Building RAPTOR Application
echo.

..\bin\rmac -fb -u -o RAPAPP.O _RAPAPP.s 
..\bin\rln -z -rq -o ..\RAPAPP.ABS -a 4000 x x RAPAPP.O ..\..\RAPTOR\RAPTOR.O ..\..\RAPTOR\RAPTOR235.O ..\..\RAPTOR\RAPTOR235.O ..\..\U235SE\DSP.OBJ

del rapapp.o

taskkill /IM virtualjaguar.exe > null.o
del null.o
start ..\bin\virtualjaguar ..\RAPAPP.ABS --alpine






