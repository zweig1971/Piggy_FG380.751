//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// *programm definitionen
//=====================================


unit TEST_GLobaleVariaben;

interface

uses Classes,Windows,UnitMil;

const
    ProtListenKopfZ1= '                           Testprotokoll IFK Piggy';
    ProtListenKopfZ2= '                          ===========================';
    ProtListenKopfZ3= '             Testergebnis';
    ProtListenKopfZ4= 'Lfd.Nr       PT   1    2    3    4    Ergebnis';
    ProtListenKopfZ5= '----------------------------------------------';

    ProtListeDatum= 'Datum: ';
    ProtListeTime= 'Uhrzeit: ';
    ProtListeTester= 'Prüfer: ';

    ProtListeUnterschrift1= '-------------------------------';
    ProtListeUnterschrift2= '          Unterschrift';

    ProtListeLegende1= 'PT: IFK programmieren';
    ProtListeLegende2= '1 : Piggy ID Test';
    ProtListeLegende3= '2 : Visueller LED Test';
    ProtListeLegende4= '3 : LED Register Test';
    ProtListeLegende5= '4 : I/O Test';

    ProtListeOK    = '   OK';
    ProtListeFail  = '    X';
    ProtListeNA    = '   NA';
    ProtLiaResFail = '   FEHLER';
    ProtLiaResSucs = '   -OK-';

    AbstandLfdTest = 10;
    DruckLinkerRand = '        ';
    //--------------------------------
    IFKVersionNr   = $1400;
    //--------------------------------
    FCWR_EnabelTreiber = $39;
    FCRD_EnabelTreiber = $A9;
    //--------------------------------
    FCWR_DirectTreiber = $3A;
    FCRD_DirectTreiber = $AA;
    //--------------------------------
    EnableTreiber = $FFFF;
    DisableTreiber= $0;
    //--------------------------------
    DirectOut = $FFFF;
    DirectIn  = $0;
    //--------------------------------
    LEDPortWR = $69;
    LEDPortRD = $9E;
    OutPortWR = $6A;
    OutPortRD = $9F;
    //--------------------------------
    PiggyIDRead = $8E;
    //--------------------------------
    WrTiming= $3C;// Timing eingang test
    RdTiming= $AC;
    //--------------------------------
    VglMaxword= 6;
    VglMaxBit = 89;
    //--------------------------------
    PgyMaxword= 3;
    PgyMaxBit = 46;
    //--------------------------------
    FktRead   = $C0;//  IFK echot ihre Nr
    IFKVersNr = $CD;//  Versionsnummer auslesen
    //--------------------------------
    IntIFKDRQ    = $2000;// Interrupts
    IntIFKDRY    = $4000;
    IntIFKINL    = $8000;
    IntIFKDRQYINL= $E000;

    IntIFKWR     = $3B;
    IntIFKRD     = $AB;

    IntrWaitTime = 5; // wartezeit zwischen senden/lesen des intr. in 10us

    //--------------------------------

     LEDIN1  = $100;   // IO
     LEDOUT1 = $80;
     LEDOUT2 = $40;
     LEDADT1 = $20;
     LEDADT2 = $10;

     SigOut1 = $8;
     SigOut2 = $4;
     SigADC1 = $2;
     SigADC2 = $1;
     //--------------------------------
     PiggyID = $50;
     //--------------------------------
     NextIFKButtonCaptDef = 'START TEST';
     NextIFKButtonCapt    = 'NEXT PIGGY';
     //--------------------------------

    AuswahlKickerKarte = false;

    //DateiTestFlashStand = '\FlashFiles\IFA8_V1P4_Test.rbf';

    DateiTestFlashStand = '\FlashFiles\*.rbf';
    DateiSaveProtVerz = '\SaveProt';
    BilderVerz = '\Bilder';
    DateiSaveProtName = 'Prot';

    BildIO_1_2 = '\FrontplattePiggy1_2.jpg';
    BildIO_1_3 = '\FrontplattePiggy1_3.jpg';
    BildIO_1_4 = '\FrontplattePiggy1_4.jpg';
    BildIO_1_5 = '\FrontplattePiggy1_5.jpg';

    BILDFront = '\FrontplattePiggyV2.jpg';
    BildTestAufbau = '\Testaufbau.jpg';

    IO_Head_Anweisung  = 'Bitte verbinden Sie';
    IO_1_2_Anweisung   = ' IN1 und OUT1';
    IO_1_3_Anweisung   = ' IN1 und OUT2';
    IO_1_4_Anweisung   = ' IN1 und ADC TRIG';
    IO_1_5_Anweisung   = ' IN1 und ADC TRIG';
    IO_close_Anweisung = ' und drücken Sie OK wenn bereit';

    ProgSetMasterOut = $200;
    //--------------------------------
    SerienNrTrennzeichen = ' ';

    //-----Zeiten fuer die programmierung----
    ProgUserFlashDelCnt  = 256;   // Schleifenzähler für das löschen des User  Flash
    ProgFiFoUserCnt      = 2000; // Schleifenzähler für die datenübernahme fifo-user
    ProgRdUserFDataValid = 2000; // Schleifenzähler für die prüfung wann die daten im userflash gültig sind


Type
    TTestResultArray = array [1..20] of boolean;

    function delChar(value:string; c:char):string;

var
   Anwendungsverzeichnis:string;
   TestDatum:string;
   TestUhrzeit:string;
   TestLfdNr:string;
   Bearbeiter:string;
   FlashFileName:string;
   TestResultArray:TTestResultArray;
   LfdNrDontShow:boolean;

   Dateiname :string;
   buffer    :string;
   FileByte  :file of Byte;
   ConfigFileSize    :integer;

   LoopCounter:longint;
   SendCounter:longint;

   FormMainPosLeft:integer;
   FormMainPosTop :integer;

   IsTestPast:boolean;
   IsProtSave:boolean;

   MBKAdress:byte;

   MBKOnline: TStrings;
   MBKOnlineNr:TStrings;
   MBKCount:integer;
   MBKOnlineIndex:integer;
   MDK_IDCODE:TStrings;

   ReadWord:RECORD CASE BYTE OF
                1:(r: PACKED RECORD
                        lb: BYTE;
                        hb: BYTE;
                       END;);
                2:(w:WORD);
                END;


implementation

// Löscht unerwünschte Zeichen aus einen string
function delChar(value:string; c:char):string;
begin
     while Pos(c,value) <> 0 do delete(value,Pos(c,value),1);
     result:= value;
end;

end.
