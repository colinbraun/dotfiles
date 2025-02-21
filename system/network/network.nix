{...}: {
  # Enable BBR congestion control
  boot.kernelModules = ["tcp_bbr"];
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";
  boot.kernel.sysctl."net.core.default_qdisc" = "fq";

  # Enable networking
  networking.networkmanager.enable = true;
}
