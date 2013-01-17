program PiggyFG380751;

uses
  Forms,
  TEST_SRNummerEingabe in 'TEST_SRNummerEingabe.pas' {SRNummerEingabe},
  TEST_AutomaticTest in 'TEST_AutomaticTest.pas' {Test_AutomaticTesTForm},
  TEST_BitteWarten in 'TEST_BitteWarten.pas' {BitteWartenForm},
  TEST_DatenEingabe in 'TEST_DatenEingabe.pas' {TEST_DatenEingabeForm},
  TEST_GLobaleVariaben in 'TEST_GLobaleVariaben.pas',
  TEST_IFKProgrammierung in 'TEST_IFKProgrammierung.pas' {IFKProgrammierungForm},
  TEST_Info in 'TEST_Info.pas' {KickerTest_Info},
  TEST_ProtokollShow in 'TEST_ProtokollShow.pas' {TEST_ProtokollShowForm},
  UnitMil in 'PCIMilTreiber_DelphiUnits\UnitMil.pas',
  TEST_IFKMainMenue in 'TEST_IFKMainMenue.pas' {IFKMainMenue},
  modulbus in 'modulbus.pas',
  BitShiftClass in 'BitShift\BitShiftClass.pas',
  TEST_LEDReg in 'TEST_LEDReg.pas',
  TEST_IOTest in 'TEST_IOTest.pas' {Form_IOTest},
  TEST_LEDTestV2 in 'TEST_LEDTestV2.pas' {Form_LEDTest},
  TEST_Testaufbau in 'TEST_Testaufbau.pas' {Form_Testaufbau};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TEST_PiggyFG380.751';
  Application.CreateForm(TIFKMainMenue, IFKMainMenue);



  Application.CreateForm(TSRNummerEingabe, SRNummerEingabe);
  Application.CreateForm(TTest_AutomaticTesTForm, Test_AutomaticTesTForm);
  Application.CreateForm(TBitteWartenForm, BitteWartenForm);
  Application.CreateForm(TTEST_DatenEingabeForm, TEST_DatenEingabeForm);
  Application.CreateForm(TIFKProgrammierungForm, IFKProgrammierungForm);
  Application.CreateForm(TKickerTest_Info, KickerTest_Info);
  Application.CreateForm(TTEST_ProtokollShowForm, TEST_ProtokollShowForm);
  Application.CreateForm(TForm_IOTest, Form_IOTest);
  Application.CreateForm(TForm_LEDTest, Form_LEDTest);
  Application.CreateForm(TForm_Testaufbau, Form_Testaufbau);
  Application.Run;
end.
