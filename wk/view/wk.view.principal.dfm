object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 321
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgcGeral: TPageControl
    Left = 0
    Top = 0
    Width = 547
    Height = 321
    ActivePage = tabFinalizar
    Align = alClient
    TabOrder = 0
    object tabVenda: TTabSheet
      Caption = 'Venda'
      ImageIndex = 1
      object grdVenda: TDBGrid
        Left = 0
        Top = 60
        Width = 539
        Height = 193
        Align = alClient
        DataSource = dsPedidoItem
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = grdVendaKeyDown
      end
      object pnlVendaSuperior: TPanel
        Left = 0
        Top = 0
        Width = 539
        Height = 60
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 10
          Top = 10
          Width = 38
          Height = 13
          Caption = 'Produto'
        end
        object Label2: TLabel
          Left = 250
          Top = 10
          Width = 24
          Height = 13
          Caption = 'Valor'
        end
        object Label3: TLabel
          Left = 325
          Top = 10
          Width = 24
          Height = 13
          Caption = 'Qtde'
        end
        object edtProduto: TEdit
          Left = 10
          Top = 25
          Width = 66
          Height = 21
          TabOrder = 0
          OnExit = edtProdutoExit
          OnKeyDown = edtProdutoKeyDown
          OnKeyPress = edtProdutoKeyPress
        end
        object edtProdutoDesc: TEdit
          Left = 80
          Top = 25
          Width = 165
          Height = 21
          TabStop = False
          Color = clSilver
          ReadOnly = True
          TabOrder = 1
        end
        object btnInserir: TButton
          Left = 405
          Top = 22
          Width = 60
          Height = 25
          Caption = 'Inserir'
          TabOrder = 4
          OnClick = btnInserirClick
        end
        object btnExcluir: TButton
          Left = 470
          Top = 22
          Width = 60
          Height = 25
          Caption = 'Excluir'
          TabOrder = 5
          OnClick = btnExcluirClick
        end
        object edtValor: TEdit
          Left = 250
          Top = 25
          Width = 70
          Height = 21
          TabStop = False
          Color = clSilver
          ReadOnly = True
          TabOrder = 2
          OnKeyPress = edtValorKeyPress
        end
        object edtQtde: TEdit
          Left = 325
          Top = 25
          Width = 70
          Height = 21
          TabOrder = 3
          OnKeyDown = edtQtdeKeyDown
          OnKeyPress = edtValorKeyPress
        end
      end
      object pnlVendaInferior: TPanel
        Left = 0
        Top = 253
        Width = 539
        Height = 40
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        DesignSize = (
          539
          40)
        object btnAvancar: TButton
          Left = 455
          Top = 6
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Avan'#231'ar >>'
          TabOrder = 0
          OnClick = btnAvancarClick
        end
      end
    end
    object tabFinalizar: TTabSheet
      Caption = 'Finalizar'
      ImageIndex = 2
      object pnlFinalizarInferior: TPanel
        Left = 0
        Top = 253
        Width = 539
        Height = 40
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          539
          40)
        object btnFinalizar: TButton
          Left = 456
          Top = 6
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Finalizar'
          TabOrder = 0
          OnClick = btnFinalizarClick
        end
        object btnVoltarVenda: TButton
          Left = 375
          Top = 6
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '<< Voltar'
          TabOrder = 1
          OnClick = btnVoltarVendaClick
        end
      end
      object pnlFinalizarSuperior: TPanel
        Left = 0
        Top = 0
        Width = 539
        Height = 253
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          539
          253)
        object Label5: TLabel
          Left = 10
          Top = 10
          Width = 33
          Height = 13
          Caption = 'Cliente'
        end
        object Label4: TLabel
          Left = 10
          Top = 60
          Width = 24
          Height = 13
          Caption = 'Total'
        end
        object edtFinTotal: TEdit
          Left = 10
          Top = 75
          Width = 520
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clSilver
          ReadOnly = True
          TabOrder = 2
          OnKeyPress = edtValorKeyPress
        end
        object edtCliente: TEdit
          Left = 8
          Top = 29
          Width = 66
          Height = 21
          TabOrder = 0
          OnExit = edtClienteExit
          OnKeyDown = edtClienteKeyDown
          OnKeyPress = edtProdutoKeyPress
        end
        object edtClienteDesc: TEdit
          Left = 80
          Top = 29
          Width = 450
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clSilver
          ReadOnly = True
          TabOrder = 1
          OnKeyPress = edtValorKeyPress
        end
      end
    end
  end
  object dsPedidoItem: TDataSource
    DataSet = dmPedido.fdmPedidoItem
    OnDataChange = dsPedidoItemDataChange
    Left = 112
    Top = 152
  end
end
