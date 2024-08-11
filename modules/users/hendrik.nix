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
}
