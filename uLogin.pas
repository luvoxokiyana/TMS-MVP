unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Skia, uDataModule, System.Hash;

type
  TForm1 = class(TForm)
    Image2: TImage;
    lblLoginHeading: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtEmail: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    Label4: TLabel;
    Image3: TImage;
    lblForgotPassword: TLinkLabel;
    CheckBox1: TCheckBox;
    pnlLogin: TPanel;
    Label5: TLabel;
    Image1: TImage;
    lblSignUp: TLinkLabel;
    Label6: TLabel;
    procedure pnlLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.pnlLoginClick(Sender: TObject);
var
  sPassword, dbPassword: string;
begin
  with dmMain.ADOQueryMain do
  begin
    Close;
    SQL.Text := 'SELECT Password FROM tblClients WHERE CompanyEmail = :email';
    Parameters.ParamByName('email').Value := edtEmail.Text;
    Open;

    if IsEmpty then
    begin
      ShowMessage('Email not found. Sign up or contact support.');
      Exit;
    end;

    dbPassword := FieldByName('Password').AsString;
    // Hash the password during sign up call
    if THashSHA2.GetHashString(sPassword) = dbPassword then
    begin
      ShowMessage('Login successful!');

    end
    else
      ShowMessage('Incorrect password.');
  end;
end;

end.
