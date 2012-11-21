//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 18.09.2008
//
// *Test Automatic Test
// *verwaltet die anzeigenmaske
// *pruefling wird mit testsoftware geimpft
// *pruefling wird nach ende mit finalen software geimpft
// *ruft die einzelnen test auf
// *ggf. wird voher initialisiert
// *ergebnisse werden ausgewertet
// *ergebnisse werden protokolliert
// *Folgende test sind hier implementiert:
// - Test_ExterneClockTest
//====================================



unit TEST_AutomaticTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TEST_GLobaleVariaben, BitShiftClass, TEST_LEDTest,
  TEST_LEDReg, UnitMil,TEST_LEDTestV2;

type
  TTest_AutomaticTesTForm = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Bevel1: TBevel;
    Test2Shape: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    Test3Shape: TShape;
    Bevel4: TBevel;
    Label9: TLabel;
    Test1Shape: TShape;
    Label10: TLabel;
    Bevel5: TBevel;
    Test1Label: TLabel;
    Test2Label: TLabel;
    Bevel6: TBevel;
    Test3Label: TLabel;
    Bevel7: TBevel;
    Label1: TLabel;
    LfdNrPanel: TPanel;
    NextIFKButton: TButton;
    EndTesTButton: TButton;
    ProgramTestVerPanel: TPanel;
    ProgramTestVerLabel: TLabel;
    Legende_ListBox: TListBox;
    Label11: TLabel;
    Bevel3: TBevel;
    Test4Shape: TShape;
    Bevel8: TBevel;
    Label2: TLabel;
    Test4Label: TLabel;
    procedure EndTesTButtonClick(Sender: TObject);
    function  Test_AutomaticTest():boolean;
    function  Test_PiggyID():boolean;
    procedure Test_FailureTestAnzeige();
    procedure Test_InitTestAnzeige();
    procedure FormShow(Sender: TObject);
    procedure Test_StartAutomaticTest();
    procedure NextIFKButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;



var
  Test_AutomaticTesTForm: TTest_AutomaticTesTForm;
  TestResultString:string;
  TestResultBool:boolean;
  LfdNrDWord:_DWORD;

implementation

uses TEST_ProtokollShow, TEST_SRNummerEingabe,TEST_IFKProgrammierung,TEST_IOTest,
  TEST_Testaufbau;

{$R *.DFM}


function  TTest_AutomaticTesTForm.Test_PiggyID():boolean;

var ErrStatus:_DWORD;
    ReadID   :_WORD;

begin
     ErrStatus:= StatusOK;

     // Piggy ID  auslesen
     PCI_IfkRead  (Cardauswahl, IFKAdress, PiggyIDRead, ReadID, ErrStatus);

     // Piggy ID vergleichgen
     if(ReadID <> PiggyID) or (ErrStatus <> StatusOK) then Test_PiggyID:= false
     else Test_PiggyID:= true;
end;

function TTest_AutomaticTesTForm.Test_AutomaticTest():boolean;

const
     PosKorY= 0;
     PosKorX= 250;
     mbYesNo= [mbYes, mbNo];

var Button:_WORD;
    ErrStatus:_DWORD;
    LEDRegTest:TLEDRegTest;
    MessPosY:integer;
    MessPosX:integer;


begin
     // Grunderscheinungsbild erstellen
     NextIFKButton.Enabled:= False;
     LfdNrPanel.Caption:= TestLfdNr;

     FormMainPosLeft:= Test_AutomaticTesTForm.Left;
     FormMainPosTop := Test_AutomaticTesTForm.Left;

     Test_InitTestAnzeige;

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 250, 1, ErrStatus);

     TestResultBool:=true;

       //-----------------------------------------
      // Test 1: Piggy ID Test
     //-----------------------------------------

     if(Test_PiggyID) then begin
        Test1Shape.Brush.Color:= clLime;
        Test1Label.Caption := '    OK';
        TestResultArray[1]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test1Shape.Brush.Color:= clRed;
        Test1Label.Caption := '  FALSE';
        TestResultArray[1]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;

       //-----------------------------------------
      // Test 2: Visueller Test (D)
     //-----------------------------------------

     //LEDTest:= TLEDTest.Create;
     //LEDTest.LEDTestStart();

     //LED Test FORM anzeigen und Test Starten
     Form_LEDTest.Show;

     //Position abhängig vom MainForm
     MessPosY:= FormMainPosTop-PosKorY;
     MessPosX:= FormMainPosLeft-PosKorX;

     Button:= MessageDlgPos('Funktionieren alle LEDs auf der Frontseite ?', mtConfirmation, mbYesNo, 0, MessPosX, MessPosY);
     //Button:= Application.MessageBox('Funktionieren alle LEDs auf der Frontseite ?','Frage',36);
     if(Button = IDYES) then begin
        Test2Shape.Brush.Color:= clLime;
        Test2Label.Caption := '    OK';
        TestResultArray[2]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test2Shape.Brush.Color:= clRed;
        Test2Label.Caption := '  FALSE';
        TestResultArray[2]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;

     Form_LEDTest.Close;

     //LEDTest.LEDTestStop();
     //PCI_TimerWait(Cardauswahl, 100, 1, ErrStatus);
     //LEDTest.Free();
     Application.ProcessMessages();
       //-----------------------------------------
      //Test 3: LED PORT TEST
     //-----------------------------------------

     LEDRegTest:= TLEDRegTest.Create;

     if(LEDRegTest.LEDRegTestStart()) then begin
        Test3Shape.Brush.Color:= clLime;
        Test3Label.Caption := '    OK';
        TestResultArray[3]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test3Shape.Brush.Color:= clRed;
        Test3Label.Caption := '  FALSE';
        TestResultArray[3]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;

     LEDRegTest.Free();
     Application.ProcessMessages();

       //-----------------------------------------
      //Test 4: Out Port Test
     //-----------------------------------------

     Form_IOTest.Show;
     if(Form_IOTest.StartIOTest()) then begin
        Test4Shape.Brush.Color:= clLime;
        Test4Label.Caption := '    OK';
        TestResultArray[4]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test4Shape.Brush.Color:= clRed;
        Test4Label.Caption := '  FALSE';
        TestResultArray[4]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;

     Application.ProcessMessages();

       //-----------------------------------------
      // Test ende
     //-----------------------------------------
     NextIFKButton.Enabled:= True;
     result:= TestResultBool;
end;


procedure TTest_AutomaticTesTForm.EndTesTButtonClick(Sender: TObject);
begin
     Test_AutomaticTesTForm.Close;
end;

procedure TTest_AutomaticTesTForm.Test_InitTestAnzeige();

begin
     Test1Shape.Brush.Color:= clWhite;
     Test2Shape.Brush.Color:= clWhite;
     Test3Shape.Brush.Color:= clWhite;
     Test4Shape.Brush.Color:= clWhite;

     Test1Label.Caption := '..ready..';
     Test2Label.Caption := '..ready..';
     Test3Label.Caption := '..ready..';
     Test4Label.Caption := '..ready..';

     Application.ProcessMessages();
end;

procedure TTest_AutomaticTesTForm.Test_FailureTestAnzeige();
begin
     Test1Shape.Brush.Color:= clRed;
     Test2Shape.Brush.Color:= clRed;
     Test3Shape.Brush.Color:= clRed;
     Test4Shape.Brush.Color:= clRed;

     Test1Label.Caption := '..ready..';
     Test2Label.Caption := '..ready..';
     Test3Label.Caption := '..ready..';
     Test4Label.Caption := '..ready..';

     Application.ProcessMessages();
end;

procedure TTest_AutomaticTesTForm.FormShow(Sender: TObject);
begin
     //------------------------------------------------
     // Grunderscheinungsbild erstellen

     NextIFKButton.Caption:= NextIFKButtonCaptDef;
     LfdNrPanel.Caption:= TestLfdNr;

     Test_InitTestAnzeige();
     ProgramTestVerPanel.Color:= clBtnFace;

     Legende_ListBox.Clear;
     Legende_ListBox.Items.Add(ProtListeLegende1);
     Legende_ListBox.Items.Add(ProtListeLegende2);
     Legende_ListBox.Items.Add(ProtListeLegende3);
     Legende_ListBox.Items.Add(ProtListeLegende4);
     Legende_ListBox.Items.Add(ProtListeLegende5);

     //---------------------------------------------------
     // variable initi.
     LfdNrDontShow:=false;
end;


// Hier wird der Test_AutomaticTest gestartet, protokolliert,
// die anzeigen gesteuert etc..
procedure TTest_AutomaticTesTForm.Test_StartAutomaticTest();

var i:integer;
    ErrorFound:boolean;
    StatusBool:boolean;
    IFKAntwort:_WORD;
    ErrStatus:_DWORD;
    myTestLfdNr:string;
    ErrorOut:TStrings;

begin
     ErrorFound:= false;
     ErrorOut:= TStringList.Create;
     ErrStatus:=StatusOK;

     //Anzeige rücksetzten
     Test_InitTestAnzeige();
     ProgramTestVerPanel.Color:= clBtnFace;

     //Beim ersten durchlauf darf die Lfd nicht geändert werden
     if(NextIFKButton.Caption= NextIFKButtonCapt) then begin
        LfdNrDWord:= StrToInt(TestLfdNr);
        LfdNrDWord:= LfdNrDWord + 1;
        TestLfdNr:= IntToStr(LfdNrDWord);
     end;

     //Beim ersten durchlauf darf die änderung der Lfd
     //nicht angezeigt werden
     if((NextIFKButton.Caption= NextIFKButtonCapt) and (LfdNrDontShow = false))then SRNummerEingabe.ShowModal;

     //Ausgabe LfdNr
     LfdNrPanel.Caption:= TestLfdNr;

     //-----------------------------------------
     // für das protokoll
     myTestLfdNr:= TestLfdNr;

     // mit Leerzeichen auffüllen
     while length(myTestLfdNr) < AbstandLfdTest do begin
          myTestLfdNr:= myTestLfdNr+' ';
     end;

     TestResultString:=myTestLfdNr;
     IsTestPast:=true;

     //-------- Pgrogrammtestfelder rücksetzten----------
     ProgramTestVerPanel.Color:= clBtnFace;
     Application.ProcessMessages();

     //----- Prüfen ob IFK Firmenware update braucht ------
     IFKAntwort:=0;
     PCI_IfkRead (Cardauswahl, IFKAdress, IFKVersNr, IFKAntwort, ErrStatus);

     //-------------------------------------------------------------
     //------ Prüfling mit fimenware impfen ---
     //-------------------------------------------------------------

     if(ErrStatus = StatusOK) then begin
        if(IFKAntwort < IFKVersionNr) then begin
          IFKProgrammierungForm.Show;
          StatusBool:=IFKProgrammierungForm.IFKProgrammierung(true,ErrorOut);
          if(StatusBool = true) then begin
            ProgramTestVerPanel.Color:= clLime;
            TestResultString:= TestResultString+ProtListeOK
          end else begin
            ProgramTestVerPanel.Color:= clRed;
            Application.MessageBox('Die IFK konnte nicht programmiert werden.','Es kann ja nicht immer regnen', 16);
            TestResultString:= TestResultString+ProtListeFail;
          end;
          Application.ProcessMessages();
        end else begin
            if not (ErrorFound) then begin
               ProgramTestVerPanel.Color:= clyellow;
               TestResultString:= TestResultString+ProtListeNA;
            end;
        end;
     end else begin
         Test_FailureTestAnzeige();
         ProgramTestVerPanel.Color:= clRed;
         TestResultString:= TestResultString+ProtListeFail;
     end;

     //-------------------------------------------------------------
     //---------------Test 1 bis 3 ---------------
     //-------------------------------------------------------------
     //Ist vorher kein fehler aufgetreten wir soll der test 1-3
     //durchgeführt werden.  Ansonsten wird abgebrochen
     if(ErrorFound= false) then StatusBool:= Test_AutomaticTest()
     else begin
       for i:=1 to 4 do begin
        TestResultString:= TestResultString+ProtListeNA;
       end;
     end;


     //-------------------------------------------------------------
     //------- Protokoll vervollstaendigen und rausschreiben--------
     //-------------------------------------------------------------
     //Sind die test erfolgreich gewesen
     if((StatusBool= true) and (ErrorFound= false)) then TestResultString:=TestResultString+ ProtLiaResSucs
     else TestResultString:=TestResultString+ ProtLiaResFail;

     //Rauschreiben
     TEST_ProtokollShowForm.ProtokollListBox.Items.Add(TestResultString);
     TestResultString:='';
     // Next
     NextIFKButton.Caption:= NextIFKButtonCapt;
end;


// Hier wird der test getsartet, vorher wird geprueft ob
// die pruefbox(MasterIFK) sich meldet
procedure TTest_AutomaticTesTForm.NextIFKButtonClick(Sender: TObject);

var ErrorFound:boolean;
    myAbbruch:boolean;
    button:_WORD;

begin
    ErrorFound:=false;
    myAbbruch:=false;

     //IFK suchen
     while (myAbbruch = false) do begin

           IFKOnline.Clear;
           IFKFound(IFKOnline, IFKCount);

           if(IFKCount  = 0) then begin
              Form_Testaufbau.Show;
              button:= Application.MessageBox('Keine IFK gefunden, bitte überprüfen Sie die Verkabelung ','Die Ente quakt gleich doppelt so laut, wenn man ihr auf den Bürzel haut',69);
              case button of
              IDRETRY: begin
                       myAbbruch:=false;
                       end;

              IDCANCEL:begin
                       myAbbruch:=true;
                       ErrorFound:= true;
                       end;
              end;
              Form_Testaufbau.Close;
           end else begin
               IFKAdress := StrToInt('$' + IFKOnline[0]);
               myAbbruch:=true;
           end;
     end;
     if(ErrorFound) = false then Test_StartAutomaticTest;
end;

end.
