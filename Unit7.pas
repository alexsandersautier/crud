unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinOffice2019Black, dxSkinOffice2019Colorful, dxSkinOffice2019DarkGray,
  dxSkinOffice2019White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxClasses, dxLayoutContainer,
  dxLayoutControl, dxLayoutControlAdapters, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  Vcl.ImgList, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Comp.Script, FireDAC.Comp.UI;

type
  TForm7 = class(TForm)
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    edtNome: TEdit;
    dxLayoutItem1: TdxLayoutItem;
    edtEndereco: TEdit;
    dxLayoutItem2: TdxLayoutItem;
    dxLayoutItem3: TdxLayoutItem;
    edtId: TEdit;
    btnIncluir: TButton;
    dxLayoutItem4: TdxLayoutItem;
    btnAlterar: TButton;
    dxLayoutItem5: TdxLayoutItem;
    btnExcluir: TButton;
    dxLayoutItem6: TdxLayoutItem;
    btnCancelar: TButton;
    btnGravar: TButton;
    dxLayoutItem7: TdxLayoutItem;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayoutGroup3: TdxLayoutGroup;
    conexao: TFDConnection;
    qryCrud: TFDQuery;
    dtsCrud: TDataSource;
    DBGrid1: TDBGrid;
    dxLayoutItem8: TdxLayoutItem;
    dxLayoutItem9: TdxLayoutItem;
    Button1: TButton;
    dxLayoutItem10: TdxLayoutItem;
    icones: TImageList;
    criaBanco: TFDScript;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure btnIncluirClick(Sender: TObject);
    procedure recarregar();
    procedure limpaCampos();
    procedure criaTabela();
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

procedure TForm7.recarregar();
begin
  with qryCrud do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from crud order by codigo');
    Open;
  end;
end;
procedure TForm7.limpaCampos();
begin
  edtId.Text:='';
  edtNome.Text:='';
  edtEndereco.Text:='';
end;
procedure TForm7.criaTabela();
begin
  criaBanco.SQLScripts.Clear;
  criaBanco.SQLScripts.Add.SQL.Text := 'create table crud (codigo serial primary key, nome varchar(60) not null, endereco varchar(100) not null)';
  if criaBanco.ExecuteAll then
    ShowMessage('Criou tabela')
  else
    ShowMessage('Não criou')
end;
{$R *.dfm}
procedure TForm7.btnExcluirClick(Sender: TObject);
var
  id:integer;
begin
  id:= StrToInt(DBGrid1.Columns.Items[0].Field.Text);
  with qryCrud do
  begin
    SQL.Clear;
    SQL.Add('delete from crud where codigo = :codigo');
    ParamByName('codigo').AsInteger := id;
    ExecSQL;
  end;
  recarregar;
end;

procedure TForm7.btnGravarClick(Sender: TObject);
begin
  with qryCrud do
  begin
    SQL.Clear;
    SQL.Add('update crud set nome = :nome, endereco = :endereco where codigo = :id');
    ParamByName('id').AsInteger := StrToInt(edtId.text);
    ParamByName('nome').AsString := edtNome.text;
    ParamByName('endereco').AsString := edtEndereco.text;
    ExecSQL;
  end;
  recarregar;
  limpaCampos;
  dxLayoutItem5.Visible:=true;
  dxLayoutItem9.Visible:=false;
end;

procedure TForm7.btnIncluirClick(Sender: TObject);
begin
  with qryCrud do
  begin
    SQL.Clear;
    SQL.Add('insert into crud(nome, endereco) values(:nome, :endereco)');
    ParamByName('nome').AsString := edtNome.text;
    ParamByName('endereco').AsString := edtEndereco.text;
    ExecSQL;
  end;
  recarregar;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
 recarregar;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
    criaBanco.SQLScripts.Clear;
    criaBanco.SQLScripts.Add.SQL.Text:='CREATE DATABASE crud';
    if criaBanco.ExecuteAll then
    begin
      ShowMessage('Passou');
      conexao.Params.Database:='crud';
      criaTabela;
    end
    else
    begin
      ShowMessage('errou');
    end;

 { with qryCrud do
  begin
    SQL.Clear;
    SQL.Add('create table crud( codigo serial primary key, nome varchar(60) not null, endereco varchar(100) not null)');
    ExecSQL;
  end;
{ with qryCrud do
  begin
    SQL.Clear;
    SQL.Add('create database crud with owner = proxsis');
    ExecSQL;
  end;
  with qryCrud do  cria usuario do banco e concede os privilégios na tabela
  begin
    SQL.Clear;
    SQL.Add('CREATE ROLE proxsis WITH LOGIN PASSWORD '+'admiral'+'');
  end;
  with qryCrud do
  begin
    SQL.Clear;
    SQL.Add('GRANT ALL PRIVILEGES ON crud TO proxsis');
  end;}
  {with qryCrud do
  begin
    SQL.Clear;
    SQL.Add('create table crud( codigo serial primary key, nome varchar(60) not null, endereco varchar(100) not null)');
    ExecSQL;
  end;  }
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  recarregar;
  limpaCampos;
  edtNome.SetFocus;
end;

procedure TForm7.btnAlterarClick(Sender: TObject);
begin
  edtId.text:=DBGrid1.Columns.Items[0].Field.Text;
  edtNome.text:=DBGrid1.Columns.Items[1].Field.Text;
  edtEndereco.text:=DBGrid1.Columns.Items[2].Field.Text;
  dxLayoutItem5.Visible:=false;
  dxLayoutItem9.Visible:=true;
end;

procedure TForm7.btnCancelarClick(Sender: TObject);
begin
  limpaCampos;
  dxLayoutItem5.Visible:=true;
  dxLayoutItem9.Visible:=false;
end;

end.
