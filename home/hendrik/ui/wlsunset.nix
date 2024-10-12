{ ... }:
{
  services.wlsunset = {
    enable = true;
    gamma = 0.8;
    latitude = 52.4;
    longitude = 9.7;
    # sunrise = "08:30";
    # sunset = "18:00";
    temperature = {
      day = 5000;
      night = 3000;
    };
  };
}
