{ pkgs, ... }: {
  # Add this to create a Ghostty configuration file
  home.file.".kube/configs/refresh.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      export KUBECONFIG="/Users/jan.hoepfner/.kube/config:$(find ~/.kube/configs -type f ! -name '*.md' ! -name '*.sh' | tr '\n' ':')"
      kubectl config view --flatten > ~/.kube/config-local
      chmod 600 ~/.kube/config-local
    '';
  };
}
