---
title: Find a Raspberry Pi on the network
description: Have a Raspberry Pi somewhere on your network, but don't know what the IP address is? All you need to do is get all the IPs on the network, and filter the ones with Raspberry Pi MAC addresses!
date: 2021-04-05
---

The command you're looking for is:

	```shell
	arp -na | grep -i b8:27:eb

	> ? (192.168.1.113) at b8:27:eb:bd:6d:e8 [ether] on wlo1 
	```

In this example, the IP of my Pi is `192.168.1.113`. If you're looking for Raspberry 4 or above, you need to swap `b8:27:eb` for `dc:a6:32`.

That's it! Told you it was simple!
