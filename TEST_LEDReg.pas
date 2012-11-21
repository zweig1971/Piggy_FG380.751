unit TEST_LEDReg;

interface

uses
    Windows,TEST_GLobaleVariaben, BitShiftClass, UnitMil;

type
    TLEDRegTest = class

public
      function LEDRegTestStart():boolean;

private
       function IFKWriteComp(SetArray:_WORD; PORTID:_BYTE):boolean;

end;

implementation

function TLEDRegTest.IFKWriteComp(SetArray:_WORD; PORTID:_BYTE):boolean;

var ErrStatus:_DWORD;
    ReadArray:WORD;
    PORTAdrWR:_BYTE;
    PORTAdrRD:_BYTE;
    SendArray:WORD;

begin
     ErrStatus:= StatusOK;
     IFKWriteComp:=true;


     case PORTID of
       1: begin PORTAdrWR:= LEDPortWR; PORTAdrRD:= LEDPortRD; SendArray:= SetArray; end;
       2: begin PORTAdrWR:= OutPortWR; PORTAdrRD:= OutPortRD; SendArray:=(SetArray and $1F0) end;
     end;

     //------------------------------------------------------
     // Schreibe an Port
     PCI_IfkWrite(Cardauswahl, IFKAdress, PORTAdrWR, SendArray,ErrStatus);
     // Lese Daten von Port
     PCI_IfkRead(Cardauswahl, IFKAdress, PORTAdrRD, ReadArray,ErrStatus);
     //vergleiche
     case PORTID of
       1: if(ReadArray <> SendArray) or (ErrStatus <> StatusOK) then IFKWriteComp:= false;
       2: if((ReadArray and $1F0) <> SendArray) or (ErrStatus <> StatusOK) then IFKWriteComp:= false;
     end;
     //------------------------------------------------------
end;


function TLEDRegTest.LEDRegTestStart():boolean;

var SetBitShiftArray:TBitShiftArray;
    ErrStatus:DWORD;
    ErrorFound:boolean;
    LEDBitShift:TBitShift;
    IndexBit:byte;
    PORTID:byte;

begin
     LEDBitShift:= TBitShift.Create;
     LEDBitShift.InitBitShift(true, 1, 16);
     LEDBitShift.resetBitShift();
     ErrorFound:=false;

     IndexBit:=0;
     while(IndexBit <= 15) do begin
       LEDBitShift.ShiftBitShift(IndexBit);
       LEDBitShift.readBitShift(SetBitShiftArray);

       //schreibe an LEDPort
       PORTID:=1;
       if not(IFKWriteComp(SetBitShiftArray[1], PORTID)) then ErrorFound:=true;
       // negiert
       if not(IFKWriteComp(not(SetBitShiftArray[1]), PORTID)) then ErrorFound:=true;

       //schreibe an Out/LEDPort
       PORTID:=2;
       if not(IFKWriteComp(SetBitShiftArray[1], PORTID)) then ErrorFound:=true;
       // negiert
       if not(IFKWriteComp(not(SetBitShiftArray[1]), PORTID)) then ErrorFound:=true;

       IndexBit:=IndexBit+1;
     end;
     PCI_IfkWrite(Cardauswahl, IFKAdress, LEDPortWR, 0,ErrStatus);
     PCI_IfkWrite(Cardauswahl, IFKAdress, OutPortWR, 0,ErrStatus);
     LEDRegTestStart:=not(ErrorFound);
end;



end.
 