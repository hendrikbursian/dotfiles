{ ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "standalone";
          outputs = [
            {
              criteria = "BOE 0x0A1C Unknown";
              mode = "1920x1080@165.004Hz";
              position = "0,0";
              scale = 1.0;
              transform = "normal";
              adaptiveSync = true;
            }
          ];
        };
      }

      {
        profile = {
          name = "docked";
          outputs = [
            {
              criteria = "ChangHong Electric Co.,Ltd PMO S273-IFC ";
              mode = "1920x1080@75.0Hz";
              position = "0,0";
              scale = 1.0;
              transform = "normal";
              adaptiveSync = true;
            }
            {
              criteria = "BOE 0x0A1C Unknown";
              status = "disable";
            }
          ];
        };
      }
    ];
  };
}

