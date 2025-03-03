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

      nix flake update
      # update packages in flake

      curl -X POST https://url -d '{"attributes": {"login_name": "fullstacks"}}'
      # curl POST

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

      bat /etc/protocols
      # see protocols and numbers

      netstat -a | grep -i "listen"
      # listening connections

      netstat -i
      # data-link statistics | get interfaces

      netstat -rn
      # display routing table

      netstat -s
      # get statistics per protocol

      netstat -ap tcp
      # filter for protocol in /etc/protocols

      lsof -i
      # -n to omit dns lookup

      lsof -iTCP -sTCP:LISTEN
      # list TCP listen sockets
      # -i{tcp/udp/4/6} -s{protocol}:{state}

      host hostname
      # nslookup replacement

      tcpdump -D
      # get available capture interfaces

      sudo tcpdump -ni 2 arp
      # listen for arp on interface 2, no DNS

      sudo tcpdump -n dst host drackthor.me and port 443
      # listen for dest website traffic

      sudo tcpdump -w /tmp/capture.pcap
      # write to .pcap file
      # read with -r /tmp/capture.pcap

      nc -v hostname port
      # open netcat tcp connection
      # -u for UDP

      nc -l port
      # listen on TCP port
      # -u for UDP

      cat asdf.txt | nc server.ip.here 11111
      # above sender, below receiver
      # nc -l 11111 > asdf.txt < /dev/null
      # send files via netcat

      tracerouce host
      # see hops to target

      whois domain
      # domain whois lookup

      ssh-add --apple-use-keychain ~/.ssh/id_rsa ~/.ssh/id_ecdsa
      # add private keys to ssh agent
    '';
  };
}
