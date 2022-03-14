object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 423
  Width = 597
  object FDQuery1: TFDQuery
    Connection = fdcConexao
    SQL.Strings = (
      'select * from usuario')
    Left = 232
    Top = 176
  end
  object fdcConexao: TFDConnection
    Params.Strings = (
      'Database=wk'
      'User_Name=root'
      'Password=root'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 152
    Top = 112
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\TESTE\WK\lib\libmysql.dll'
    Left = 304
    Top = 240
  end
end
