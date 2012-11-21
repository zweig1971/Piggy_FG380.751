unit TEST_LEDTestV2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, UnitMil, BitShiftClass, ExtCtrls,TEST_GLobaleVariaben;

type
  TForm_LEDTest = class(TForm)
    Timer_LED: TTimer;
    Image_FrontLED: TImage;
    Shape_LED: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer_LEDTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

   private
    { Private-Deklarationen }
    SetBitShiftArray:TBitShiftArray;
    LEDBitShift:TBitShift;
    OutLEDBitShift:TBitShift;
    ErrStatus:_DWORD;
    LEDIndex:_BYTE;

  public
    { Public-Deklarationen }
  end;

var
  Form_LEDTest: TForm_LEDTest;

implementation

{$R *.DFM}

procedure TForm_LEDTest.FormShow(Sender: TObject);
begin
     Form_LEDTest.Left:= FormMainPosLeft+400;
     Timer_LED.Enabled:=true;
     LEDIndex:=0;

     //Lade bild
     try
      Image_FrontLED.Picture.LoadFromFile(Anwendungsverzeichnis+BilderVerz+BILDFront);
     except
     end;
end;


procedure TForm_LEDTest.FormCreate(Sender: TObject);
begin
    Shape_LED.Shape:=stCircle;
    Shape_LED.Width := 9;
    Shape_LED.Height:= 13;
    //----
    Shape_LED.Left  := 6;
    Shape_LED.Top   := 375;
    //----
    Shape_LED.Visible:= false;
    //----
    LEDBitShift:= TBitShift.Create;
    LEDBitShift.InitBitShift(true, 1, 16);
    LEDBitShift.resetBitShift();
    //----
    OutLEDBitShift:= TBitShift.Create;
    OutLEDBitShift.InitBitShift(true, 1, 9);
    OutLEDBitShift.resetBitShift();
    //----
    Timer_LED.Enabled:=false;
end;

procedure TForm_LEDTest.Timer_LEDTimer(Sender: TObject);

begin
   // OUT-Port LEDs
    //-------------------------------------------------------

    ErrStatus:= StatusOK;

    if(LEDIndex<= 8) then begin
      Shape_LED.Visible:= true;
      OutLEDBitShift.ShiftBitShift(LEDIndex);
      OutLEDBitShift.readBitShift (SetBitShiftArray);

      PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, (SetBitShiftArray[1] and $1F0),ErrStatus);

      if (ErrStatus = StatusOK) then begin
         if(LEDIndex < 4) then Shape_LED.Visible:= false;

         if(LEDIndex = 4) then begin
           Shape_LED.Top:=375;
           Shape_LED.Left:= 6;
           Shape_LED.Visible:= true;
         end;

         if(LEDIndex > 4) then Shape_LED.Top:= Shape_LED.Top-25;
         Form_LEDTest.Update;
      end;
    end else PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, 0,ErrStatus);


    //  LED-Leiste
    //-------------------------------------------------------

    if (LEDIndex >= 9) then begin
      Shape_LED.Visible:= true;
      LEDBitShift.ShiftBitShift(LEDIndex);
      LEDBitShift.readBitShift(SetBitShiftArray);

      PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, SetBitShiftArray[1],ErrStatus);

      if (ErrStatus = StatusOK) then begin
         if(LEDIndex = 9) then begin
           Shape_LED.Left:= 7;
           Shape_LED.Top := 249;
         end;

         if(LEDIndex >9) then begin
           if(LEDIndex = 12)  then Shape_LED.Top:= 212+13;
           if(LEDIndex = 15)  then Shape_LED.Top:= 177+13;
           if(LEDIndex = 23) then Shape_LED.Top:= 76+13;
           Shape_LED.Top:= Shape_LED.Top-13;
         end;
      end;

      Form_LEDTest.Update;
    end else PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, 0,ErrStatus);

    LEDIndex:=LEDIndex + 1;

    // ENDE
    //-------------------------------------------------------
    if(LEDIndex > 24)then begin
      PCI_TimerWait(Cardauswahl, 200, 1, ErrStatus);
      LEDIndex:= 0;
      Shape_LED.Visible:= false;

      LEDBitShift.resetBitShift();
      OutLEDBitShift.resetBitShift();

      PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, 0,ErrStatus);
      PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, 0,ErrStatus);

      Form_LEDTest.Update;
    end;

end;

procedure TForm_LEDTest.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Timer_LED.Enabled:=false;
     Shape_LED.Visible:= false;
     LEDBitShift.resetBitShift();
     PCI_IfkWrite (Cardauswahl, IFKAdress, LEDPortWR, 0,ErrStatus);
     PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, 0,ErrStatus);
     Form_LEDTest.Update;
end;

end.
