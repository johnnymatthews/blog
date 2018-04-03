# My Shockingly Un-scientific Study of Chrome and Firefox

So a new Firefox version came out a few weeks ago. Everyone's been claiming that it's super fast and has overcome it's sluggish past. There's even been some journalists saying it's faster as less resource heavy than Chrome. I wanted to find out for myself, so I did a few tests.

Everything in this *study* was performed on the same 2016 Macbook Air (8GB), and on the same WiFi network, in the same geographical space (my desk). Chrome is updated to version 62.0.3202.94 (Official Build) (64-bit), and Firefox is at 57.0 (64-bit).

With that out of the way, let's get into it.

## Is Firefox Slower Than Chrome When Opening GitLab?
Pretty simple question really. I want to know if Firefox takes longer to fully load a GitLab page than Chrome. I'd noticed Firefox lagging a little bit when trying to open some GitLab pages, and thought I'd test it.

So I open Firefox, went to [GitLab.com](https://www.gitlab.com), signed in, clicked on a repo, clicked on a folder inside that repo, and finally clicked on a file inside that folder inside that repo. At each step I took a screenshot of the network console to get the load times and download sizes of each page. 

I then did the **exact same** with Chrome. I also disabled all extentions in both browsers, and cleared the caches. 

I *was* going to run this test in private mode, but I thought that wouldn't actually give the results I'm looking for, since I want to know which browser is faster in everyday use.

### Results

<span>Orange</span> highlights the better result.

| Page | Chrome | Firefox |
| ---- | ------ | ------- |
| [Home](https://about.gitlab.com/)| `Requested: 89`<br> `Transfered: 1.7MB`<br> <span>`Finished: 3.46s`</span><br> <span>`DOM: 1.76s`</span><br> `Load: 2.40s` | <span>`Requested: 49`</span><br> <span>`Transfered: 2.57MB / 1.56MB`</span><br> `Finished: 3.79s`<br> `DOM: 2.19s`<br> <span>`Load: 2.02s`</span> |
| [Login](https://gitlab.com/users/sign_in)| `Requested: 31`<br> `Transfered: 802KB`<br> <span>`Finished: 1.76s`</span><br> `DOM: 1.17s`<br> <span>`Load: 1.69s`</span> | <span>`Requested: 23`</span><br> <span>`Transfered: 3.88MB / 792.21KB`</span><br> `Finished: 1.98s`<br> <span>`DOM: 1.01`</span><br> `Load: 1.71s` |
| [Dashboard](https://gitlab.com/)| `Requested: 15`<br> <span>`Transfered: 153KB`</span><br> <span>`Finished: 1.73s`</span><br> <span>`DOM: 0.754s`</span><br> <span>`Load: 1.25s`</span> | <span>`Requested: 14`</span><br> `Transfered: 2.92MB / 189.41KB`<br> `Finished: 2.35s`<br> `DOM: 1.49s`<br> `Load: 1.57s` |
| Repo | `Requested: 18`<br> <span>`Transfered: 153KB`</span><br> <span>`Finished: 2.13s`</span><br> <span>`DOM: 1.38s`</span><br> <span>`Load: 1.38s`</span> | <span>`Requested: 15`</span><br> `Transfered: 2.92MB / 155.08KB`<br> `Finished: 2.78s`<br> `DOM: 1.70s`<br> `Load: 1.78s` |
| Folder | `Requested: 16`<br> <span>`Transfered: 49KB`</span><br> <span>`Finished: 1.44s`</span><br> <span>`DOM: 1.02s`</span><br> <span>`Load: 1.13s`</span> | <span>`Requested: 12`</span><br> `Transfered: 2.86MB / 86.47KB`<br> `Finished: 1.53s`<br> `DOM: 1.09s`<br> `Load: 1.16s` |
| File | `Requested: 16`<br> <span>`Transfered: 3.1MB`</span><br> <span>`Finished: 3.21s`</span><br> <span>`DOM: 1.11s`</span><br> <span>`Load: 1.10s`</span> | <span>`Requested: 13`</span><br> `Transfered: 5.97MB / 3.18MB`<br> `Finished: 3.57s`<br> `DOM: 1.17s`<br> `Load: 1.24s`|

Man, these results are pretty mad. Firefox was pulling ahead for the first couple of pages, but then it looks like Chrome's aggressive caching helped it's load speeds catch up! 

What I'm finding a bit odd is how the requests and transfers are complelely different between browsers, and that Firefox consistently requests less documents from Gitlab than Chrome does.

## Which One Uses More RAM?
So for this I again cleared the caches for both browsers, and opened the exact same pages in the exact same order, all the while recording the total memory usage of each browser in Activity Monitor (essentially Task Manager for OSX).

And before you ask, no I wasn't running any Electron based applications. The only other applications I have running are a VPN client, iTunes, and Sublime.

### Single Tab Results

I'm going to start things off with just the standard blank page that both Chrome and Firefox offer. This way we've got a benchmark for what the browsers look like when nothing's going on.

<span>Orange</span> highlights the better result.

| Page | Chrome | Firefox |
| ---- | ------ | ------- |
| Idle Benchmark | <span>147.8MB</span> | 220.9MB |
| [Home](https://about.gitlab.com/) | <span>179MB</span> | 267.2MB |
| [Login](https://gitlab.com/users/sign_in) | <span>241.2MB</span> | 383.9MB |
| [Dashboard](https://gitlab.com/) | <span>177.3MB</span> | 358.2MB |
| Repo | <span>196.2MB</span> | 401.4MB |
| Folder | <span>154.8MB</span> | 422MB |
| File | <span>193.2MB</span> | 488.7MB |

Well this is interesting, Firefox clearly uses more RAM than Chrome.  I'm now starting to think that I might be adding this up wrong, or not taking something into account. Saying that, this is only with one tab open. I've heard that Chrome likes to open up multiple instances of itself for each tab. 

### Multiple Tabs Results
This time I'm gonna see what the results are like when six tabs are open. I could open more, but I very rarely go past six, as I like to use the `CMD` + `1:6` hotkeys to switch quickly. And in the interest of keeping this interesting, I'll open a few different types of web pages:

 1. This [Reddit](https://www.reddit.com/r/videos/comments/7gd7zf/avengers_infinity_war_trailer/) post about the new Marvel trailer
 2. This [/r/webdev post](https://www.reddit.com/r/webdev/comments/7gdo0q/when_you_build_a_thing_of_beauty_for_a_client_and/) about some random guy's client
 3. TheDeMocracy's Dark Souls 3 [Speedrun Walkthrough](https://www.youtube.com/watch?v=XpHA5F2_ywE)
 4. Evan Yeung's [Terminal Slack](https://github.com/evanyeung/terminal-slack) Github repo
 5. My [Backup & Restore](https://github.com/mohnjatthews/dkan-backup-and-restore) repo for DKAN
 6. My [Gmail](https://mail.google.com/mail/u/0/#inbox) inbox

Again, I won't have any Electron based programs open to give Chrome a fair change. I'm not going to bother clearing the caches again, can't really see any point since both browsers have visit the exact same sites. Once all the tabs are open I'll take three screenshots of activity monitor ten seconds appart, and then average the results together.

*I used GitHub instead of GitLab so that there won't be much interfence in the way of caching. Also, this way you guys can all play-along at home!

<span>Orange</span> highlights the better result.

| Page | Chrome | Firefox |
| ---- | ------ | ------- |
| Idle Benchmark | <span>136.7MB</span> | 255MB |
| First | <span>806.6MB</span> | 885.5MB |
| Second | <span>777.6MB</span> | 1073.4MB |
| Third | <span>752.2MB</span> | 927.1MB |
| Average (without benchmark) | <span>778.8MB</span> | 962MB |

Yet again, Chrome comes out on top! Clearly I've been reading to wrong articles about the browser wars!

## Coolest Loading Icons?
It's Firefox. There's no point debating it.

![Loading Icons](media/firefox/loading-icons.gif)


## Conclusion
So at the start of this article, I was sure that using Firefox was the best move. That I was saving my poor little 8GB of RAM from the monolith that is Google Chrome. But clearly I'm mistaken! According to these results, Firefox is the behemoth I should be avoiding. 

The main benefit of using Firefox however, is that all my data doesn't get fed off to Google! But I also like having a system that runs nice and smooth. Time to pick a side I guess.

Again, keep in mind that I'm not a data scientist or a network tech.

<!--ARTICLE SPECIFIC CSS-->
<style>span {color: orange}</style>
<!--/ARTICLE SPECIFIC CSS-->