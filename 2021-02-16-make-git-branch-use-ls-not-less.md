---
title: Make git branch use ls, not less.
description: A while ago, the maintainer of Git decided that git branch should act like less instead of ls. That was a terrible decision that made me very upset. Fortunately, the maintaners decided to leave a configuration option to let me change it back. Lovely.
date: 2021-02-16
---

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
