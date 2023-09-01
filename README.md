# .vcaen (Vadim's Dotfiles) 🧗🏻‍♂

## What Are Dotfiles?

The term "dotfiles" is derived from files whose names have a dot `.` as a prefix. These files are typically hidden in Linux and macOS environments and are used to store configurations for various programs.

If you want to preserve the customizations you've made to these configuration files, it's a good practice to back them up somewhere. I decided to take the GitHub route to share them with the world.

## 🌟 What Makes My Dotfiles Special?

I've been working on Android at Google for 7 years, and my dotfiles reflect the tools I need to boost productivity.

I usually share them with new teammates when they join the team to help them set up their own workflows. But I also emphasize that they should cherry-pick the tools they need because, ultimately, the best workflow for you is the one you create for yourself.

## My Workflow

To get a better understanding of what's inside my dotfiles, let me explain the tools I use:

- 🖥️ **Hardware**
  - I primarily work on a Linux desktop, whether locally or remotely via my Mac.

- 🐚 **Shell**
  - My shell is configured with [zsh] using [Oh My Zsh] to enhance the experience.
  - I mostly use [tmux], but a few of my scripts aren't dependent on it.
  - I recently discovered [fzf], and I'm integrating it more and more into my scripts.
  - I don't have a particular preference for terminal emulators; I use kitty, gnome-terminal, and iTerm2 on Mac.

- 🪛 **Tools**:
  - I extensively use Git and [repo] (a wrapper by Google for managing multiple Git repositories concurrently). You can find many useful aliases in my [.gitconfig](git/gitconfig).
  - My window manager of choice is [i3wm] (made by another Googler 😉).
  - I rely on IntelliJ/Android Studio and VS Code as my main IDEs and file editors.

- 🦀 **Rust Tools**
  - I don't develop much in Rust, but the Rust package manager provides some really cool tools that I use daily, such as [bat], [ag] (aka "The Silver Searcher"), and [fd-find].

## 🖌️ Color Schemes

- [IntelliJ Dark Theme](Vadim%20Scheme.icls)

  ![IntelliJ Dark Theme](https://github.com/vcaen/intellij-color-scheme/raw/master/screenshot.png)

- [IntelliJ Light Theme](Vadim_light.icls) (for sunny days or when I need to wake up)

  ![IntelliJ Light Theme](screenshots/light_theme.png)

[zsh]: https://wiki.archlinux.org/title/zsh
[Oh My Zsh]: https://ohmyz.sh
[bat]: https://github.com/sharkdp/bat
[ag]: https://github.com/ggreer/the_silver_searcher
[fd-find]: https://github.com/sharkdp/fd
[fzf]: https://github.com/junegunn/fzf
[i3wm]: https://i3wm.org/
[tmux]: https://github.com/tmux/tmux/wiki
[repo]: https://gerrit.googlesource.com/git-repo/
