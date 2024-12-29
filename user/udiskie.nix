{...}: {
  # Note: This service requires udisks2 to be enabled in order for it to work.
  services.udiskie = {
    enable = true;
    automount = true;
    tray = "auto"; # Only show in tray when there is a device to show
    notify = true;
  };
}
