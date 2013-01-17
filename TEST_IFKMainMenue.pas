//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// TEST-IFK MainMenue
// *Der einstiegspunkt
//====================================

unit TEST_IFKMainMenue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls;

type
  TIFKMainMenue = class(TForm)
    Panel1: TPanel;
    EXIT_Button: TButton;
    AutomaticTest_Button: TButton;
    MainMenu1: TMainMenu;
    About_Menue: TMenuItem;
    FlashFile1: TMenuItem;
    OpenFlashFile: TOpenDialog;
    procedure EXIT_ButtonClick(Sender: TObject);
    procedure AutomaticTest_ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure About_MenueClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FlashFile1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  IFKMainMenue: TIFKMainMenue;


implementation

uses TEST_DatenEingabe, TEST_AutomaticTest,
  TEST_ProtokollShow, UnitMil, TEST_GLobaleVariaben, TEST_Info,
  TEST_IFKProgrammierung,TEST_Testaufbau;

{$R *.DFM}

procedure TIFKMainMenue.EXIT_ButtonClick(Sender: TObject);
begin
      IFKMainMenue.Close;
end;


procedure TIFKMainMenue.AutomaticTest_ButtonClick(Sender: TObject);

var x:integer;


begin
     //=====================================================
     //prüfen ob das verszeichnis für die protokolldatei angelegt ist
     // aktuelles verzeichnis ermitteln
     //======================================================
     //GetDir(0,Anwendungsverzeichnis);
     if ((not FileExists(Anwendungsverzeichnis+DateiTestFlashStand)) and (FlashFileName = DateiTestFlashStand)) then begin
        Application.MessageBox('Wichtige Dateien (.rbf) konnten nicht gefunden werden, bitte überprüfen Sie die Installation'
                              ,'Der Ausweg führt durch die Tür.Warum benutzt niemand die Tür ?',16);

         IFKMainMenue.FlashFile1.Click;
     end else begin


         Form_Testaufbau.Close;
         IsTestPast:=false;

         TEST_DatenEingabeForm.ShowModal;
         TEST_AutomaticTesTForm.ShowModal;

         if(IsTestPast = true) then begin
           //Leerzeichen einfuegen
           for x:=1 to 10 do begin
               TEST_ProtokollShowForm.ProtokollListBox.Items.Add('');
           end;

           //Unterschrift
           TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeUnterschrift1);
           TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeUnterschrift2);

           //Leerzeichen einfuegen
           for x:=1 to 3 do begin
               TEST_ProtokollShowForm.ProtokollListBox.Items.Add('');
           end;

           //Legende
           TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende1);
           TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende2);
           TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende3);
           TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende4);
           TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende5);
           TEST_ProtokollShowForm.ShowModal;
         end;
     end;
end;


procedure TIFKMainMenue.FormCreate(Sender: TObject);

var status:_DWORD;
    ErrorFound:boolean;
    Abbruch:boolean;
    button:_WORD;
    IFKAntwort:_WORD;
    ErrStatus:_DWORD;
    FoundCards:_WORD;


begin
     ErrorFound:=false;
     abbruch:=false;

     // pfad zum flash file festlegen
     FlashFileName:= DateiTestFlashStand;

     //IFKOnline liste erstellen
     IFKOnline   := TStringList.Create;
     Cardauswahl:=1;

     // aktuelles verzeichnis ermitteln
     GetDir(0,Anwendungsverzeichnis);

     //=====================================================
     // PCiI MilKarte suchen und öffnen
     //=====================================================
     FoundCards:= PCI_PCIcardCount();
     if(FoundCards <> 0) then begin
       status:= PCI_DriverOpen(Cardauswahl);
       if (status <> StatusOK) then begin
          Application.MessageBox('Open PCI-MilCard FAILURE !','Shit',16);
          ErrorFound:=true;
         end;
     end else begin
         Application.MessageBox('No PCI-MilCard found !','Shit happens',16);
         ErrorFound:= true;
     end;

     // IFKs suchen
    IFKFound(IFKOnline, IFKCount);

    // Erste IFK nehmen
    try
       IFKAdress := StrToInt('$' + IFKOnline[0]);
     except
       messagebox(0,'Keine IFK gefunden !','Warnung',16);
       IFKAdress := 0;
    end;

     if(ErrorFound =  true) then begin
       IFKMainMenue.Close;
       Application.Terminate;
     end;
end;

procedure TIFKMainMenue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     PCI_DriverClose(Cardauswahl);
end;

procedure TIFKMainMenue.About_MenueClick(Sender: TObject);
begin
     KickerTest_Info.ShowModal;
end;

procedure TIFKMainMenue.FormShow(Sender: TObject);
begin
     Form_Testaufbau.Show;
end;

procedure TIFKMainMenue.FlashFile1Click(Sender: TObject);

begin
     OpenFlashFile.Filter:= 'Flash File(*.rbf)|*.rbf';
     OpenFlashFile.DefaultExt:='rbf';
     OpenFlashFile.InitialDir:= extractfilepath(paramstr(0));

     if OpenFlashFile.Execute then begin
        FlashFileName := OPenFlashFile.FileName;
     end;

     if(FlashFileName = '') then FlashFileName:= DateiTestFlashStand;

end;

end.
