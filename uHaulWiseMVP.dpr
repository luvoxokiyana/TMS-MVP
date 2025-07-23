program uHaulWiseMVP;

uses
  Vcl.Forms,
  uLogin in 'uLogin.pas' {Form1},
  uDataModule in 'uDataModule.pas' {dmMain: TDataModule},
  uMain in 'uMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
