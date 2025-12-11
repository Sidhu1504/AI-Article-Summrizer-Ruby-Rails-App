{ pkgs, ... }:
{
  # Recommended for Ruby projects
  packages = [ pkgs.ruby pkgs.libyaml pkgs.postgresql ];
  # Non-language packages
  dev-packages = [ pkgs.git ];

  # Specify the version of Ruby to use
  languages.ruby = {
    enable = true;
    version = "3.1"; # Or "2.7", "3.0", "3.2"
  };

  # Enable this to get automatic shell activation
  # automatic-shell-activation = {
  #   enable = true;
  # };

  # Set environment variables
  # env = {
  #   RAILS_ENV = "development";
  # };

  # Add any commands you want to run when the environment is created
  startup-commands = [
    "sudo service postgresql start"
  ];
}
