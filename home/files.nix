{ pkgs, ... }: {
  # Add this to create a Ghostty configuration file
  home.file.".kube/configs/refresh.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      export KUBECONFIG=$(find ~/.kube/configs -type f ! -name '*.md' ! -name '*.sh' | tr '\n' ':')
      kubectl config view --flatten > ~/tmp/all-in-one-kubeconfig.yaml
      mv ~/tmp/all-in-one-kubeconfig.yaml ~/.kube/config
      chmod 600 ~/.kube/config
      export KUBECONFIG=~/.kube/config
    '';
  };
}
