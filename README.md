# ek

My personal emacs package creator.

There is no standart how to build an emacs package, and the idea behind `ek` is definitly not to come up with something like that.
`ek` is just my personal CLI tool for my daily emacs lisp hacking. There are conventions in the Emacs community how emacs packages are structured
and with `ek` I try to get with these.

`ek` uses [Cask](https://github.com/cask/cask) for package dependency and [ert-runner](https://github.com/rejeep/ert-runner.el) for running tests in a handy way.

## Installation

You need to have [Erlang](http://www.erlang.org/download.html) installed on your system to run the executable `escript` `ek` binary.

Just use the following `wget` command to get `ek` into your home bin directory. (`~/bin/ek`)

```sh
  $ wget -P ~/bin https://github.com/tonini/ek/raw/master/bin/ek && chmod +x ~/bin/ek
```

## Usage

![ek](http://i.imgur.com/oUgUm7t.png)

## Contributing

Contributions are very welcome!

1. Fork ek
2. Create a topic branch - `git checkout -b my_branch`
4. Push to your branch - `git push origin my_branch`
5. Send me a pull-request for your topic branch
6. That's it!

## License

Copyright © 2015 Samuel Tonini and
[contributors](https://github.com/tonini/ek/contributors).

See [LICENSE](LICENSE) for details.

[badge-license]: https://img.shields.io/badge/license-GPL_3-green.svg
