unit TEST_IOTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, UnitMil, ExtCtrls,TEST_GLobaleVariaben;

type
  TForm_IOTest = class(TForm)
    Panel2: TPanel;
    Image_FrontPiggy: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    function IOSend(SigOut:_WORD):boolean;
  public
    { Public-Deklarationen }
    function StartIOTest():boolean;
  end;

var
  Form_IOTest: TForm_IOTest;

implementation

{$R *.DFM}


function TForm_IOTest.StartIOTest():boolean;

const
     PosKorY= 0;
     PosKorX= 250;
var
   ErrStatus:_DWORD;
   Button:_WORD;
   Errfound :boolean;
   Status:boolean;
   MessPosY:integer;
   MessPosX:integer;



begin
     Errfound     := false;
     ErrStatus    := StatusOK;

     MessPosY:= FormMainPosTop-PosKorY;
     MessPosX:= FormMainPosLeft-PosKorX;


     // Alles LEDs aus
     PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, 0, ErrStatus);

     //-----------------------------------------------------------
     // TEST IN1 -------- OUT1

     //Lade bild
     try
      Image_FrontPiggy.Picture.LoadFromFile(Anwendungsverzeichnis+BilderVerz+BildIO_1_2);
     except
     end;

     //LEDs an
     PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, (SigOut1 or LEDIN1 or LEDOUT1), ErrStatus);

     //Anweissung schreiben
    // Button:= Application.MessageBox(IO_Head_Anweisung+IO_1_2_Anweisung+IO_close_Anweisung,'Hinweis',65);
     Button:= MessageDlgPos(IO_Head_Anweisung+IO_1_2_Anweisung+IO_close_Anweisung, mtInformation, mbOKCancel, 0, MessPosX, MessPosY);
     if(Button = IDOK) then begin
         Status:=IOSend(SigOut1);
         if not(Status) then Errfound:= true;
      end else begin
         Errfound:= true;
     end;

     //-----------------------------------------------------------
     // TEST IN1 -------- OUT2

     if not (Errfound)  then begin

        //Lade bild
        try
           Image_FrontPiggy.Picture.LoadFromFile(Anwendungsverzeichnis+BilderVerz+BildIO_1_3);
        except
        end;

        //LEDs an
        PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, (SigOut2 or LEDIN1 or LEDOUT2), ErrStatus);

        //Anweissung schreiben
        //Button:= Application.MessageBox(IO_Head_Anweisung+IO_1_3_Anweisung+IO_close_Anweisung,'Hinweis',65);
        Button:= MessageDlgPos(IO_Head_Anweisung+IO_1_3_Anweisung+IO_close_Anweisung, mtInformation, mbOKCancel, 0, MessPosX, MessPosY);
        if(Button = IDOK) then begin
            Status:=IOSend(SigOut2);
            if not(Status) then Errfound:= true;
        end else begin
            Errfound:= true;
        end;
     end;


     //-----------------------------------------------------------
     // TEST IN1 -------- ADC TRIG1

     if not (Errfound)  then begin
        //Lade bild
        try
           Image_FrontPiggy.Picture.LoadFromFile(Anwendungsverzeichnis+BilderVerz+BildIO_1_4);
        except
        end;

        //LEDs an
        PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, (SigADC1 or LEDIN1 or LEDADT1), ErrStatus);

        //Anweissung schreiben
        //Button:= Application.MessageBox(IO_Head_Anweisung+IO_1_4_Anweisung+IO_close_Anweisung,'Hinweis',65);
        Button:= MessageDlgPos(IO_Head_Anweisung+IO_1_4_Anweisung+IO_close_Anweisung, mtInformation, mbOKCancel, 0, MessPosX, MessPosY);
        if(Button = IDOK) then begin
            Status:=IOSend(SigADC1);
            if not(Status) then Errfound:= true;
        end else begin
            Errfound:= true;
        end;
     end;

     //-----------------------------------------------------------
     // TEST IN1 -------- ADC TRIG2

     if not (Errfound)  then begin
        //Lade bild
        try
           Image_FrontPiggy.Picture.LoadFromFile(Anwendungsverzeichnis+BilderVerz+BildIO_1_5);
        except
        end;

        //LEDs an
        PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, (SigADC2 or LEDIN1 or LEDADT2), ErrStatus);

        //Anweissung schreiben
        //Button:= Application.MessageBox(IO_Head_Anweisung+IO_1_5_Anweisung+IO_close_Anweisung,'Hinweis',65);
        Button:= MessageDlgPos(IO_Head_Anweisung+IO_1_5_Anweisung+IO_close_Anweisung, mtInformation, mbOKCancel, 0, MessPosX, MessPosY);
        if(Button = IDOK) then begin
            Status:=IOSend(SigADC2);
            if not(Status) then Errfound:= true;
        end else begin
            Errfound:= true;
        end;
     end;

     //-----------------------------------------------------------

     if not(Errfound) and (ErrStatus= StatusOK) then StartIOTest:=true
     else StartIOTest:= false;

     //LEDs aus
     PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, 0, ErrStatus);

     Form_IOTest.Close;
end;

//Signale an IO-Port senden/lesen und vergleichen
function TForm_IOTest.IOSend(SigOut:_WORD):boolean;

const IN1Mask = $8000;

var ReadData:_WORD;
    ErrStatus:_DWORD;

begin
     ErrStatus:= 0;
     // Signal an I/O senden
     PCI_IfkWrite (Cardauswahl, IFKAdress, OutPortWR, SigOut, ErrStatus);
     // IN1 auslesen
     PCI_IfkRead  (Cardauswahl, IFKAdress, OutPortRD, ReadData, ErrStatus);
     //In1 ausmakieren
     ReadData:= ReadData and IN1Mask;
     //muss null sein
     if(ReadData = 0) and (ErrStatus= StatusOK) then IOSend:=true
     else IOSend:= false;
end;


procedure TForm_IOTest.FormShow(Sender: TObject);
begin
     Form_IOTest.Left:= FormMainPosLeft+400;
end;

end.
