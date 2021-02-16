---
title: Make git branch use ls, not less.
date: 2021-02-16
---

# Make `git branch` use `ls` not `less`

By default, Git uses `less` when outputting all the branches of a repo:

```shell
git branch

>   add/calculate-the-datasize
>   add/fil-wallets
>   add/infura-getting-started
>   feat/lotus-1-5-0
>   master
>   update/lotus-snapshots
>   update/switch-network-instructions
> * updates/more-references
> (END)
```

This formatting is stupid, and I don't like it. I want `git branch` to behave more like `ls` and simply list all the available branches without taking up the full terminal window.

To do so, set `pager.branch` to `false:

```shell
git config --global pager.branch false
```

Now `git branch` shows this:

```shell
git branch

>   add/calculate-the-datasize
>   add/fil-wallets
>   add/infura-getting-started
>   feat/lotus-1-5-0
>   master
>   update/lotus-snapshots
>   update/switch-network-instructions
> * updates/more-references
```

Done!
