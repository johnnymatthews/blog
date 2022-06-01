---
title: "How to store private information on a public network"
description: "This is a bit of a silly question: _how do you store private information on a public network?_ I guess one question is _why would you bother doing that in the first place? If you've got private information, store it on a private network_. And that's a fair statement to make. "
date: 2022-06-01
---

But, if you want to store data on a blockchain, that data is public by default. You can either:

- only store public information on a blockchain, or
- you can find a way to obfuscate and encrypt your data so that it becomes incredibly difficult to make sense of it all.

We're gonna talk about the second way.

## Encrypt your stuff

This first step to securing your data is to encrypt it. However, you can't just encrypt it with a single GPG/PGP key and call it a day. There's a very real chance that someone in the future will find a flaw or exploit the encryption process you used. So, you'll have to encrypt your data multiple times, using different encryption techniques. It also doesn't hurt to use encryption tools that are quantum resistant.

So you do that; you grab your data, compress it into a single file, and then encrypt the living crap out of it until you've got a garbled mess of bytes that no one can make sense of except you. What next? Can you put it on the blockchain now? Well, you _could_, but there's another thing you can do to make things even more secure.

<picture>
    <source srcset="./encryption-path-white.png" media="(prefers-color-scheme: dark)">
    <img src="./encryption-path-black.png">
</picture>

## Split it up

Chop it up. Grab your single file, split it up into several segments, and then upload them to the chain, preferably sending the transactions from separate addresses. This way, if an attacker grabs a single piece of your data, they won't be able to begin un-encrypting your data since they'll need all the pieces of the puzzle. You could also throw in random blocks of encrypted garbage into the mix by uploading them to the chain, leading an attacker to believe that they're also part of the _whole_ and attempt to decrypt them with the others.

<picture>
    <source srcset="./transaction-process-white.png" media="(prefers-color-scheme: dark)">
    <img src="./transaction-process-black.png">
</picture>

## The puzzling problem

Now, to me, this seems like a pretty decent way to minimize the risk that someone will be able to make sense of your messed-up data. However, there's also the chance that you lose one of your decryption keys, forget what order the blocks need to go in to be decrypted, or misplace your transaction IDs so you can't find the data, to begin with. The biggest problem with obfuscating and encrypting your data is that it's fairly easy to forget how to put the puzzle back together again. And I can't argue against that. You could make a tool for how you put things back together again, but what if an attacker grabs hold of that tool?

## Work work

The best way to figure out how to deal with this problem is to do the first part of this solution myself. Grab some data, encrypt the crap out of it, split it up, and upload it to Filecoin using several different addresses. Along the way, I'll play around with ways to record my process safely.

Keep an eye out for part two.

