{ systemSettings, inputs, ... }:

{
  home.packages = [
    inputs.suyu.packages.${systemSettings.system}.default
  ];
}

