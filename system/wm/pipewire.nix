{ pkgs, ... }:
{
  # Pipewire
  # sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Includes pactl
  environment.systemPackages = with pkgs; [
    pulseaudioFull
  ];
}
