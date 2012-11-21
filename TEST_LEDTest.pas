 unit TEST_LEDTest;

interface

uses
    Windows,TEST_GLobaleVariaben, BitShiftClass, UnitMil;

type
    TLEDTest = class

protected
      ThreadID:DWORD;
      ThreadHandle: THandle;
      function  LEDTestThread():boolean; stdcall;
      procedure LEDTestOFF();

public
      function LEDTestStart():boolean;
      function LEDTestStop ():boolean;
end;

var LEDAbruch:boolean;

implementation

function TLEDTest.LEDTestThread():boolean; stdcall;

var SetBitShiftArray:TBitShiftArray;
    LEDBitShift:TBitShift;
    OutLEDBitShift:TBitShift;
    LEDIndexBit:_BYTE;
    OUTIndexBit:_BYTE;
    ErrStatus:_DWORD;

begin
    LEDBitShift:= TBitShift.Create;
    LEDBitShift.InitBitShift(true, 1, 16);
    LEDBitShift.resetBitShift();
    //----
    OutLEDBitShift:= TBitShift.Create;
    OutLEDBitShift.InitBitShift(true, 1, 9);
    OutLEDBitShift.resetBitShift();
    //----
    ErrStatus:= StatusOK;
    while(LEDAbruch<> true) do begin

       LEDIndexBit:=0;
       OUTIndexBit:=0;
       LEDBitShift.resetBitShift();
       OutLEDBitShift.resetBitShift();

       //erst der OUT/LED Port
       while (OUTIndexBit <= 8) and (LEDAbruch <> true) do begin
             OutLEDBitShift.ShiftBitShift(OUTIndexBit);
             OutLEDBitShift.readBitShift(SetBitShiftArray);
             PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, (SetBitShiftArray[1] and $1F0),ErrStatus);
             PCI_TimerWait(Cardauswahl, 150, 1, ErrStatus);
             OUTIndexBit:=OUTIndexBit+1;
       end;

       // OUT/LED Port aus
       PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, 0,ErrStatus);

       // Dann der LED-Port
       while (LEDIndexBit <= 15) and (LEDAbruch <> true) do begin
             LEDBitShift.ShiftBitShift(LEDIndexBit);
             LEDBitShift.readBitShift(SetBitShiftArray);
             PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, SetBitShiftArray[1],ErrStatus);
             PCI_TimerWait(Cardauswahl, 150, 1, ErrStatus);
             LEDIndexBit:=LEDIndexBit+1;
       end;

       // LED-Port aus
       PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, 0,ErrStatus);

       // Alle LEDs an
       PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, $FFFF,ErrStatus);
       PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, $1F0,ErrStatus);

       PCI_TimerWait(Cardauswahl, 400, 1, ErrStatus);

       // Alle LED-Port aus
       PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, $0,ErrStatus);
       PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, $0,ErrStatus);
    end;

    // Alle LED-Port aus
    PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, $0,ErrStatus);
    PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, $0,ErrStatus);


    if(ErrStatus = StatusOK) then LEDTestThread:= true
    else LEDTestThread:= false;
end;


procedure TLEDTest.LEDTestOFF();

var ErrStatus:_DWORD;

begin
    // Alle LED-Port aus
    PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, $0,ErrStatus);
    PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, $0,ErrStatus);
end;


function TLEDTest.LEDTestStart():boolean;
begin
    LEDAbruch:=false;
    ThreadHandle:=CreateThread(nil, 0, TFNThreadStartRoutine(@TLEDTest.LEDTestThread),NIL, 0, ThreadID);
    if(ThreadHandle <> 0) then LEDTestStart:= true
    else LEDTestStart:= false;

end;

function TLEDTest.LEDTestStop ():boolean;

var ErrStatus:_DWORD;

begin
  LEDAbruch:= true;
  PCI_TimerWait(Cardauswahl, 100, 1, ErrStatus);
  if (ThreadHandle<>0) then begin
     CloseHandle(ThreadHandle);
     LEDTestOFF();
     LEDTestStop:= true
  end else LEDTestStop:= false;
end;



end.
