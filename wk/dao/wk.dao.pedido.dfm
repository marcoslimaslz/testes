object dmPedido: TdmPedido
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 457
  Width = 503
  object fdmPedido: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 65
    Top = 108
    object fdmPedidoCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object fdmPedidoIDCliente: TIntegerField
      FieldName = 'IDCliente'
    end
    object fdmPedidoCliente: TStringField
      FieldName = 'Cliente'
      Size = 50
    end
  end
  object fdmPedidoItem: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 65
    Top = 172
    object fdmPedidoItemCodigo: TIntegerField
      DisplayLabel = 'Item'
      FieldName = 'Codigo'
    end
    object fdmPedidoItemIDProduto: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'IDProduto'
    end
    object fdmPedidoItemProduto: TStringField
      DisplayWidth = 20
      FieldName = 'Produto'
      Size = 50
    end
    object fdmPedidoItemPreco: TFloatField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'Preco'
    end
    object fdmPedidoItemQuantidade: TFloatField
      FieldName = 'Quantidade'
    end
    object fdmPedidoItemTotal: TFloatField
      FieldName = 'Total'
    end
  end
end
