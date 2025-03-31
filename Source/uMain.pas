unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ExtDlgs,
  Vcl.Imaging.pngimage;

type
  TfrmMain = class(TForm)
    eImage: TImage;
    eText: TMemo;
    eDest: TImage;
    btnDraw: TButton;
    btnSave: TButton;
    SavePictureDialog1: TSavePictureDialog;
    procedure btnDrawClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Save(const AFileName: string);
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmMain.btnDrawClick(Sender: TObject);
begin
  var LRect := Rect(eText.Left - eImage.Left,
    eText.Top, eText.Left - eImage.Left + eText.Width, eText.Height);
  var LText: string := eText.Text;
  with eDest.Picture.Bitmap.Canvas do
  begin
    // 텍스트 위치의 배경을 흰색으로 지우고
    Brush.Color := clWhite;
    FillRect(LRect);

    // 글꼴 설정하고 그리기
    Font.Color := clBlack;
    Font.Assign(eText.Font);
    TextRect(LRect, LText, [tfWordBreak, tfRight, tfVerticalCenter]);
  end;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute(Handle) then
    Save(SavePictureDialog1.FileName);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  eText.SelectAll;
end;

procedure TfrmMain.Save(const AFileName: string);
begin
  var LPNGImage := TPNGImage.Create;
  try
    LPNGImage.Assign(eDest.Picture.Bitmap);
    LPNGImage.SaveToFile(AFileName);
  finally
    LPNGImage.Free;
  end;
end;

end.
