object DMGlobal: TDMGlobal
  OnCreate = DataModuleCreate
  Height = 158
  Width = 251
  object FDConn: TFDConnection
    BeforeConnect = FDConnBeforeConnect
    Left = 64
    Top = 48
  end
  object FDPhys: TFDPhysMSSQLDriverLink
    Left = 144
    Top = 48
  end
end
