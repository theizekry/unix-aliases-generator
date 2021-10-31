## **_Unix Aliases Manager_**

It's a simple way to generate and manage your aliases for your Mac and/or Linux environment by a simple bash command, With more features.

---

## **Features and overview**
- Easy way to keep your commands in aliases.
- Dealing with DotFiles [More Info](https://dotfiles.github.io/).
- ✨Magic ✨ Multiple devices and synchronization.

## **Installation**

```bash
cd ~ && git clone git@git.izekry
```

Now, after cloning, you've to define your last Manual alias to keep the command simple and easy.

If you're a macOS user and use iTerm it's by default **zsh** shell,
and your shell profile file will be in **~/.zshrc**. the same with Linux users and also you're using ZSH it will be the same filename and in the same path.

if you're not, the default bash profile file will be **~/.bashrc**.

So, depending on your active shell profile (Bash Or Zsh ...) you've to open it.

```bash 
sudo nano ~/.zshrc or sudo nano ~/.bashrc
```

Now, put the following at the end of the file.

```bash 
# Unix Aliases Manager.
alias aliases='bash ~/linux-aliases-generator/main.sh'
```

Please note that ~/.bash_aliases file only works if the following line presents

in the ~/.bashrc or ~.zshrc file.

So make sure to add the following block in your shell profile.

```bash 
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
```

Refresh your Shell Profile.

```bash
source ~/.zshrc or source ~/.bashrc 
```
---

# **How to use ?**

### # Set new alias
```bash
aliases set-new <alias-name> <command|alias-value>
```

Examples:

if you want to add new alias for git diff.

or you've something like Laravel artisan `php artisan ...`

or you want to navigate to specific directory by simple word ( cd ~/code/foobar/etc ...).

> aliases set-new gd 'git diff'
> 
> aliases set-new pa 'php artisan ' or aliases set-new art 'php artisan '
> 
> aliases set-new py 'cd ~/xyz/foobar/development/python/python-projects'
> 

Just it, added successfully and ready to use without closing your terminal or even source ( reload ) your shell profile as before this tool.

---

### # Synchronization

if you want to keep your aliases up to date and/or you're dealing with **Dotfiles** you will love this feature. by applying the set-new command and just adding **--sync** in the first time you've to configure it by answering to a simple question Where's your Dotfiles repository path is? Just it, you're done.

```bash
aliases set-new <alias-name> <command|alias-value> --sync
```

Also, if you've some aliases are not synced with your remote repository for any reason. You may go offline with an internet issue, forget to sync while setting new alias, don't worry you will be able to use this tool without any issue and as soon as your connection is restored. run the following command to sync the local to your remote repository.

```bash
run aliases sync
```
---
### # Multiple Devices

If you use more than one device, such as Personal Laptop and company Laptop, or you've Linux device beside MacBook.

You may need your all aliases that you use in the main device to be available in the second one and for simplicity you just use **--local-to-remote** option with **sync command**. to update your local by your remote repository by single command as bellow.

```bash
aliases sync --local-to-remote
```
---

### # Need Help ?
For more info and usage!

```bash
> aliases -h
> or aliases --help
```

-----------

## Contribution guidelines

If you face any issue, please report it in the issues page.

and for sure pull requests are welcome.

## **License**
Free to use, Hell Yeah!