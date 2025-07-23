unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmMain = class(TDataModule)
    ADOQueryMain: TADOQuery;
    DSMain: TDataSource;
    ADOConnectionMain: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  ADOQueryMain.Connection := ADOConnectionMain;
  ADOQueryMain.SQL.Text := 'SELECT * FROM tblClients';
  ADOQueryMain.Open
end;

end.
