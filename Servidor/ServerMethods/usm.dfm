object sm: Tsm
  OldCreateOrder = False
  Height = 166
  Width = 273
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server=192.168.15.24'
      'DriverID=Mongo')
    Left = 48
    Top = 40
  end
  object FDPhysMongoDriverLink1: TFDPhysMongoDriverLink
    Left = 152
    Top = 40
  end
end
