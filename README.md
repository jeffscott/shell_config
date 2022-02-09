# shell_config

## New Machine Shell Setup
Run the following
```./init```

* This will save your existing `~/.vimrc` file as `~/.vimrc_old`
* This will save your existing `~/.bash_profile` file as `~/.bash_profile`
* This will save your existing `~/.bash_aliases` file as `~/.bash_aliases`

The config files for `vim` and `bash` will be installed in `$HOME`

## Post Installation (Fuzzy Persistent History)

This sections details how to make `ctrl-r` (reverse i search) to use ripgrep/fzf for fuzzy seraching of persistent command line history across all terminal sessions. It is life changing. You never need to remember/save a command again, just start typing random stuff you remember of a command and it will show up. The package manager version (brew) didn't work for me, I had to install from git.

### Dependencies

* [fzf](https://github.com/junegunn/fzf) - Fuzzy command line search run
* [ripgrep](https://github.com/BurntSushi/ripgrep#installation) - Fast grep 

```
brew install fzf
brew install ripgrep
```


https://github.com/junegunn/fzf#key-bindings-for-command-line

```
git clone https://github.com/junegunn/fzf.git
cd fzf
./install
```

You must add the following to `~/.fzf/.fzf.bash`. I didn't get this setup to work on `zsh` yet, I'm sure it will eventually. 
```
__fzf_history__() (
 local line
 shopt -u nocaseglob nocasematch
 line=$(
   cat ~/.persistent_history |
   $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
  \grep '^ *[0-9]') && sed 's/^ *\([^|]*| \)\(.*\)/\2/' <<< "$line"
)
```