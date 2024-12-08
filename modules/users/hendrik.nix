{ pkgs, ... }:

{
  users.users.hendrik = {
    isNormalUser = true;
    description = "Hendrik Bursian";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
    shell = pkgs.zsh;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    initialPassword = "test"; # For testing vms
  };

  security.pki.certificates = [
    # mitmproxy certificate
    ''
      -----BEGIN CERTIFICATE-----
      MIIDNTCCAh2gAwIBAgIUFCoZDmzNaf1aR7OYdAYDE1T+LgIwDQYJKoZIhvcNAQEL
      BQAwKDESMBAGA1UEAwwJbWl0bXByb3h5MRIwEAYDVQQKDAltaXRtcHJveHkwHhcN
      MjQwODEyMTc0MzQ3WhcNMzQwODEyMTc0MzQ3WjAoMRIwEAYDVQQDDAltaXRtcHJv
      eHkxEjAQBgNVBAoMCW1pdG1wcm94eTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
      AQoCggEBAMR4qb0esVlWRbjeDVaZ9P24/Xuauudt5MgCP0DewoVLl6dcDwSpj2Cn
      hayRO62Hbpgie7/Mo9fbfpBgZXxniVacQW5IRMCHLJfbIt14+UcjDNhrpUbAKOVO
      guA3I7Wt8MX7RPFBZhb0ZfNanWgDL8X/ml/DYHiM3r7I7Ke0KksmnpLcGnDUrCU9
      bP7rK94wKdpzteYPvvqphk0yce1kcsDiEpMFo8J3wXyGXj6jkzTG9vBhfFRCxbJV
      xa2wXWFDIHBqem/Or5owW6MAnq8MfmwQb/gecz98PwUCT3aF0tXX/9o0g2GYaxNu
      4aqGNyHAJQU2pqhC+66cTazmRmfmG3cCAwEAAaNXMFUwDwYDVR0TAQH/BAUwAwEB
      /zATBgNVHSUEDDAKBggrBgEFBQcDATAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYE
      FNuxx6XAdziNexD3cwVVrWn6iDJeMA0GCSqGSIb3DQEBCwUAA4IBAQBEVitxj1/J
      uZBEMiYzsx9JEJCXfwyveUXBJBeA3yKIog1VQaN3U1gXPjJoK4nyGWvZJ3vdSrdW
      QagG7iXfn+nnzWlPkh+8TG4fxS7Gf6As3yvfJ4eyIJGIQmCETQh8fXpoGNT3GrP+
      xVT3orYts2GOiXUl83Hglv3KmOhShFbymbwYVpREq9IvrNvfz+eVA1yzwJ4av1O8
      +jlTeNRh1Phqrg3rXxyLXV1b9U3xBSdIPnbVkeyzTdeX12lXoUCkJ0dtC4Nbw1jP
      MjqsDKxl7xowoq+81gNgOIz2STc/CCOq7fvYVWvHZLpbVmF0qw3cF5FvApAjiaB4
      mK0G2Loa8Hrw
      -----END CERTIFICATE-----
    ''
  ];
}
