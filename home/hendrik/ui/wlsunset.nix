{ ... }:
{
  services.wlsunset = {
    enable = true;
    gamma = 0.8;
    sunrise = "07:30";
    sunset = "18:00";
    temperature = {
      day = 5000;
      night = 3000;
    };
  };
}
