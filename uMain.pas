unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, MSHTML, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, System.JSON, uDataModule, Vcl.Skia;

type
  TfrmMain = class(TForm)
    sSidebar: TShape;
    Label1: TLabel;
    imgLogo: TImage;
    lblTracking: TLabel;
    pgcMain: TPageControl;
    Label7: TLabel;
    tsDashboard: TTabSheet;
    pnlDeliveries: TPanel;
    lblActiveOrders: TLabel;
    pnlOrderNill: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    wbDashboard: TWebBrowser;
    sbOrders: TScrollBar;
    tsAnalytics: TTabSheet;
    pnlOngoingTrips: TPanel;
    pnlCancelledTrips: TPanel;
    edtOrders: TSearchBox;
    DBGrid1: TDBGrid;
    pnlTotalTrips: TPanel;
    Label8: TLabel;
    wbanalytics: TWebBrowser;
    lblOngoingripsHeading: TLabel;
    lblNumberofOngoingTrips: TLabel;
    lblNUmberofCancelledTrips: TLabel;
    lblCancelledTripsHeading: TLabel;
    lblNumberofTotalTrips: TLabel;
    lblTotalTrips: TLabel;
    Label9: TLabel;
    tsSubscripions: TTabSheet;
    Label10: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Label11: TLabel;
    tsSubscription: TToggleSwitch;
    Label12: TLabel;
    pbOrders: TProgressBar;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Panel7: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    tsDeliveries: TTabSheet;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtPickupLoc: TEdit;
    edtDropoffLoc: TEdit;
    memNotes: TMemo;
    Panel8: TPanel;
    IdHTTP1: TIdHTTP;
    Label25: TLabel;
    lblCompanyName: TLabel;
    lblCompanyEmail: TLabel;
    Panel9: TPanel;
    Image1: TImage;
    procedure Panel8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowRouteOnMap(PickupLat, PickupLng, DropoffLat,
      DropoffLng: Double);
    function GetCoordinates(Address: string): string;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
{ TfrmMain }

function TfrmMain.GetCoordinates(Address: string): string;
var
  Http: TIdHTTP;
  Response: string;
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  Latitude, Longitude: string;
  URL: string;
begin
  Address := StringReplace(Address, ' ', '+', [rfReplaceAll]);
  URL := 'https://nominatim.openstreetmap.org/search?q=' + Address +
    '&format=json';

  Http := TIdHTTP.Create(nil);
  try
    Http.Request.UserAgent := 'DelphiApp'; // required by Nominatim
    Response := Http.Get(URL);
    JSONArray := TJSONObject.ParseJSONValue(Response) as TJSONArray;

    if (JSONArray.Count > 0) then
    begin
      JSONValue := JSONArray.Items[0];
      Latitude := JSONValue.GetValue<string>('lat');
      Longitude := JSONValue.GetValue<string>('lon');
      Result := Latitude + ',' + Longitude;
    end
    else
      Result := 'Not found';
  finally
    Http.Free;
  end;
end;

procedure TfrmMain.Panel8Click(Sender: TObject);
var
  PickUpCoords, DropOffCoords: string;
begin
  PickUpCoords := GetCoordinates(edtPickupLoc.Text);
  DropOffCoords := GetCoordinates(edtDropoffLoc.Text);

  with uDataModule.dmMain.ADOQueryMain do
  begin
    SQL.Clear;
    SQL.Text :=
      'Insert INTO tblOrders (PickupAddress, DropoffAddress, CreatedAt) ' +
      ' VALUES (:pickup, :dropoff, : created)';
      Parameters.ParamByName('pickup').Value := edtPickupLoc.Text;
      Parameters.ParamByName('droppoff').Value := edtDropoffLoc.Text;
      Parameters.ParamByName('created').Value := Now;

      try
        ExecSQL;
        ShowMessage('Order successfullt added');
      except
       on E: Exception do
        ShowMessage('Error: ' + E.Message);

      end;
  end;
end;

procedure TfrmMain.ShowRouteOnMap(PickupLat, PickupLng, DropoffLat,
  DropoffLng: Double);
var
  JS: string;
begin
  JS := Format('showRoute(%f, %f, %f, %f);', [PickupLat, PickupLng, DropoffLat,
    DropoffLng]);
  wbDashboard.OleObject.Document.parentWindow.execScript(JS, 'JavaScript');
end;

end.
