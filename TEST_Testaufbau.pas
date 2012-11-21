unit TEST_Testaufbau;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  jpeg, ExtCtrls,TEST_GLobaleVariaben;

type
  TForm_Testaufbau = class(TForm)
    Image_Testaufbau: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form_Testaufbau: TForm_Testaufbau;

implementation

{$R *.DFM}

procedure TForm_Testaufbau.FormCreate(Sender: TObject);
begin
     //Lade bild
     try
      Image_Testaufbau.Picture.LoadFromFile(Anwendungsverzeichnis+BilderVerz+BildTestAufbau);
     except
     end;
end;

end.
