{ pkgs,... }:
{
    home.file.".library" = {
        executable = false;
        text = ''
            # DrackThor's Command Library
            lsof -i # open network connections
            find / -type f -name '*changeme*'
            darwin-rebuild switch --flake ~/code/repos/drackthor/nix-darwin # rebuild nix
            curl -X POST https://url -d '{"attributes": {"login_name": "fullstacks"}}' # curl POST
            netstat -a | grep -i "listen" # listening connections
        '';
  };
}
