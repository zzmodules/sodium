sodium
======

> [WIP] libsodium bindings for [ZZ][zz].

## Installation

Put this in your `zz.toml`:

```toml
[repos]
sodium = "git://github.com/zzmodules/sodium"
```

## Usage

```c++
using sodium::{
  sodium_init
}
```


## Version

The version of this module maps directly to the version of libsodium used by
this module.

## License

MIT

[zz]: https://github.com/zetzit/zz
