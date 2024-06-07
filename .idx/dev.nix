# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nano
    # pkgs.gitflow
    pkgs.openssh
    pkgs.zip
    pkgs.unzip
    pkgs.wget
    pkgs.curl
    pkgs.docker
    pkgs.bun
    # pkgs.go
    # pkgs.python311
    # pkgs.python311Packages.pip
    pkgs.nodejs_20
    # pkgs.nodePackages.nodemon
    pkgs.hostname-debian
    pkgs.helix
  ];
  services.docker.enable = true;
  # Sets environment variables in the workspace
  env = {
    PORT=3080;
    BROADCAST_IP="0.0.0.0";
    # HOST="$WEB_HOST";
    API_SERVICE="https://$PORT-$WEB_HOST";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
      "SpaceBox.monospace-idx-theme"
      "ms-azuretools.vscode-docker"
      "mhutchie.git-graph"
      "donjayamanne.githistory"
      "waderyan.gitblame"
      # "Serhioromano.vscode-gitflow"
      "ms-vscode.hexeditor"
      "esbenp.prettier-vscode"
      "ms-vscode.js-debug"
      "ms-vscode.vscode-typescript-tslint-plugin"
      "dbaeumer.vscode-eslint"
      "rvest.vs-code-prettier-eslint"
      "cweijan.vscode-database-client2"
      "jeppeandersen.vscode-kafka"
    ];
    # Enable previews
    previews = {
      enable = false;
      previews = {
        # web = {
        #   # Example: run "npm run dev" with PORT set to IDX's defined port for previews,
        #   # and show it in IDX's web preview panel
        #   command = ["npm" "run" "dev"];
        #   manager = "web";
        #   env = {
        #     # Environment variables to set for your server
        #     PORT = "$PORT";
        #   };
        # };

        web = {
          env = {
            port=3080;
            host="0.0.0.0";
          };
          command = [
            "bun" "run" "build;"
            "bun" "run" "start"
            "--"
            # "--port" "$port"
            # "--host" "$host"
            "--disable-host-check"
          ];
          manager = "web";
        };
      };
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        # Example: install JS dependencies from NPM
        # npm-install = "npm install";
      };
      # Runs when the workspace is (re)started
      onStart = {
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";

        reload-envs = "source /home/user/.bashrc";

        # NOTE: Run this manually much better!
        # ide-on-start = "npm run idx:init";
      };
    };
  };
}
