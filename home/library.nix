{ pkgs, ... }: {
  home.file.".library" = {
    executable = false;
    # DrackThor's Command Library
    text = ''
      lsof -i
      # open network connections

      find / -type f -name '*changeme*'
      # find files

      darwin-rebuild switch --flake ~/code/repos/drackthor/nix-darwin
      # rebuild nix darwin dystem

      curl -X POST https://url -d '{"attributes": {"login_name": "fullstacks"}}'
      # curl POST

      netstat -a | grep -i "listen"
      # listening connections

      zsh_stats
      # show most used commands

      cnspec scan docker image changeme
      # scan image with cnspec

      cnspec scan container registry harbor.url
      # scan registry with cnspec

      cnspec scan local --policy-bundle POLICYFILE.yaml --incognito
      # scan without storing results in Mondoo Platform

      cnspec scan host hostname
      # scan TLS for hostname

      drawio -x -f png -o modules/ROOT/images modules/ROOT/assets/
      # antora build drawio diagrams

      pre-commit run --all-files
      # run pre-commit on all files

      pre-commit install && pre-commit install --hook-type commit-msg
      # install pre-commit hooks in repo
    '';
  };
}
