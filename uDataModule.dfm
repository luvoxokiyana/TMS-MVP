object dmMain: TdmMain
  OnCreate = DataModuleCreate
  Height = 108
  Width = 341
  object ADOQueryMain: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *  FROM tblClients')
    Left = 120
    Top = 16
  end
  object DSMain: TDataSource
    DataSet = ADOQueryMain
    Left = 51
    Top = 16
  end
  object ADOConnectionMain: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\luvox\OneD' +
      'rive\Documents\MVP\MainDB.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 226
    Top = 16
  end
end
