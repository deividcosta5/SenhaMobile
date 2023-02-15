unit View.Camera;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Media, ZXing.ScanManager, ZXing.ReadResult, ZXing.BarcodeFormat,
  FMX.Platform;

type
  TfrmCamera = class(TForm)
    CameraComponent: TCameraComponent;
    txtErro: TText;
    imgCamera: TImage;
    ImgClose: TImage;
    procedure CameraComponentSampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure FormShow(Sender: TObject);
    procedure ImgCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FScanManager: TScanManager;
    FScanInProgress: Boolean;
    FFrameTake: Integer;
    procedure ProcessarImagem;
  public
    { Public declarations }
    Codigo: String;
  end;

var
  frmCamera: TfrmCamera;

implementation

{$R *.fmx}

procedure TfrmCamera.ProcessarImagem;
var
  Bmp: TBitmap;
  ReadResult: TReadResult;
begin
  CameraComponent.SampleBufferToBitmap(imgCamera.Bitmap, True);

  if FScanInProgress then
    Exit;

  Inc(FFrameTake);

  if (FFrameTake mod 4 <> 0) then
    Exit;

  Bmp := TBitmap.Create;
  Bmp.Assign(imgCamera.Bitmap);
  ReadResult := nil;

  try
    FScanInProgress := True;
    try
      ReadResult := FScanManager.Scan(Bmp);
      if ReadResult <> nil then
      begin
        CameraComponent.Active := False;
        Codigo := ReadResult.Text;
        Close;
      end;
    except on E: Exception do
      txtErro.Text := E.Message;
    end;
  finally
    Bmp.DisposeOf;
    ReadResult.DisposeOf;
    FScanInProgress := False;
  end;

end;

procedure TfrmCamera.FormCreate(Sender: TObject);
begin
  FScanManager := TScanManager.Create(TBarcodeFormat.Auto, nil);
end;

procedure TfrmCamera.FormDestroy(Sender: TObject);
begin
  FScanManager.DisposeOf;
end;

procedure TfrmCamera.FormShow(Sender: TObject);
begin
  FFrameTake := 0;
  CameraComponent.Active := False;
  CameraComponent.Kind := TCameraKind.BackCamera;
  CameraComponent.FocusMode := TFocusMode.ContinuousAutoFocus;
  CameraComponent.Quality := TVideoCaptureQuality.LowQuality;
  CameraComponent.Active := True;
end;

procedure TfrmCamera.ImgCloseClick(Sender: TObject);
begin
  CameraComponent.Active := False;
  Close;
end;

procedure TfrmCamera.CameraComponentSampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
  ProcessarImagem;
end;

end.
