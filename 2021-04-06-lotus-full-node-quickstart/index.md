---
title: Lotus full-node quickstart
description: Wanna spin up a Lotus full-node on the Filecoin network, but don't wanna have to slog through the docs? Run these commands in order to get everything built and installed super quick.
date: 2021-04-06
---

Here's what you need to run:

```shell
sudo apt update -y && sudo apt upgrade -y
sudo apt install mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
wget -c https://golang.org/dl/go1.16.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc && source ~/.bashrc
git clone https://github.com/filecoin-project/lotus.git
cd lotus/
make clean all
sudo make install
```

Now you should be able to run `lotus daemon` and everything will just start! If you wanna use a snapshot instead of syncing the whole chain, run: `lotus daemon --import-chain https://fil-chain-snapshots-fallback.s3.amazonaws.com/mainnet/complete_chain_with_finality_stateroots_latest.car` instead.
