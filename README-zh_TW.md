# someonethere介紹

Someonethere 可以讓你在子網域找到其他電腦或機器。前提是要先在其他電腦上安裝此服務。

這個專案有兩個執行程式：

"someonethere"是個在本地端執行的程式，會對UDP 8613埠廣播"someonethere"訊息。並等待一秒鐘看看是否有其他機器回應。

"utp-reply-someonethere"是跑在遠端機器裡的服務(daemon or service)。此服務會在 UDP 8613 埠等待 "someonethere" 的訊息。
當等到"someonethere"訊息之後，會回覆自己的"domain name"和"IP address"。
 

## 下載 及 安裝

### 原始碼
原始碼在github上的[lihow731的someonethere專案](https://github.com/lihow731/someonethere).

```
git clone https://github.com/lihow731/someonethere
```


### 安裝 Debian package

在 ubuntu 16.04 下，可以用下面指令安裝：

```
sudo add-apt-repository ppa:lihow731/ppa
sudo apt-get update
sudo apt-get install someonethere
```

##檔案:

在這個專案裡，有下面幾個主要的檔案：

* udp-reply-someonethere:

    這是一個服務程式，它會聆聽 UDP 8613 埠。
    當收到"someonethere"時，會回應domain name和IP address。
    在Linux環境下，我們可以將它放在 _/usr/bin/_.

* someonethere: 

    這是一個用戶端的程式，它會對UDP 8613埠廣播"someonethere"訊息。
    並等待一秒鍾看看是否有回應。有其他機器回應時，就會將結果顯示出來。
    在Linux環境下，我們可以將它放在 _/usr/bin/_.
    
* urs.service:

    這是給ubuntu 16.04 (xenial)用的檔案。
    只要新版的ubuntu持續的使用systemd，這個檔案就可以用。
    將這個檔案放在 _/lib/systemd/system/_.

* urs:

    這個給 ubuntu 14.04 (trusty) 和 Raspbian 8.0 (jessie)用的啟動程式。
    將這個檔案放在 _/etc/init.d/_.
    使用下面這個指令可以讓udp-reply-someonethere在開機時自動執行。
    
    `$ update-rc.d urs defaults`

    註：有人可以告訢我怎麼將 debian package 推到 Raspbian 的 ppa 上嗎？

## 使用方法

先在遠端的機器上執行:

```
$ udp-reply-someonethere
```


當你想知道那些遠端機器的IP時：

```
$ someonethere
```

## 製作 Debian package

在ubuntu 16.04下，直接執行下面指令(需要簽章)：

```
dpkg-buildpackage
```

如果您未修改任東西，可以用下面指令製作一個沒有簽章的 debian package.

```
dpkg-buildpackage -us -uc -sa
```
