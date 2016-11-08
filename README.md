# neat

> Minimal zsh prompt inspired by [odin][odin] and [pure][pure]

![](screenshot.png)

## Install

```sh
npm install -g neat-prompt
```

And add `neat` to plugin list in your `.zshrc`:

```zsh
plugins=(neat)
```

Or clone this repo and append next line to your `.zshrc`:

```zsh
source neat/neat.zsh
```

## Indicators

Prompt git and other indicators:

* `⋯` — untracked files in repo
* `✓` — files added
* `⚑` — modified files
* `✖` — deleted files
* `➜` — renamed files
* `‼` — unmerged files
* `↑` — repo is ahead of current branch
* `↓` — repo is behind
* `⚡` — discharged battery indicator

## License

MIT

[odin]: https://github.com/tylerreckart/Odin
[pure]: https://github.com/sindresorhus/pure
