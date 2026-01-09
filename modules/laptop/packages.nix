{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
      acpi tlp git
  ];
}