# atsboot

A tiny 32 bit kernel written in ATS.

This was largely based on the
[rustboot](https://github.com/charliesome/rustboot) project which does
the same but using [Rust](http://www.rust-lang.org/).

It paints the screen bright red and then hangs. That's it:

![](http://i.imgur.com/aglQ890.png)

## Setup

You need a few things to run atsboot:

1. qemu
2. a cross-compiler for i386
3. nasm
4. [ATS2 Positiats](http://www.ats-lang.org/DOWNLOAD/)

## Running it

To compile, simply

```sh
$ make
```

To run,

```sh
$ make run
```
