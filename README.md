🚀 What is it?
<img width="1561" height=<img width="1561" height="911" alt="Screenshot_20250819_213740" src="https://github.com/user-attachments/assets/88c7da05-0622-41f3-8c17-20d24b5d5ac2" />


aur-auto is a lightweight script/app that makes it easier to install packages from the Arch User Repository (AUR) without needing a full-blown helper like yay or paru.

It’s designed for people who:

Prefer a minimal solution instead of a big wrapper.

Want to see package details (maintainer, version, description) before installing.

Like a guided interactive experience with auto-suggestions.

Need something scriptable but still user-friendly.

🖼 Why Use It Instead of Yay/Paru?
Sometimes you don’t want the complexity of a full AUR helper.

You may just need to install a couple of AUR packages manually but hate typing git clone … && cd … && makepkg.

Great for beginners who want to learn how AUR works but still need a helping hand.

Can be integrated into scripts or dotfiles for bootstrapping a new Arch system.

https://aur.archlinux.org/packages/aur-auto

https://github.com/Sanjaya-Danushka/whalekit

How to download and use it

Option 1: Manual installation
Install base dependencies (if not already installed):


sudo pacman -S --needed base-devel git curl jq fzf
Clone your AUR repo:


git clone https://aur.archlinux.org/aur-auto.git
cd aur-auto
Build and install:


makepkg -si
how to use it

aur-auto <package name>
aur-auto swap

 I’ve already made changes to improve the script: 🚫 It no longer installs yay paru google-chrome visual-studio-code-bin by default when run without arguments. Now, if you run aur-auto with no args, it just prints usage help (aur-auto <package>). ⚠️ I removed the forced sudo pacman -Syu --noconfirm. The script now only installs dependencies when you confirm, so it won’t unexpectedly upgrade your system. 🔄 It doesn’t just touch the official repo anymore — AUR packages are handled safely, and system updates are left to the user. 📂 Fixed the build loop: it now cleans up properly, returns to the working directory after each package, and doesn’t reassign TMPDIR unnecessarily. ❌ Added error handling: if a build fails, the script stops and shows the error instead of blindly continuing. 🛠️ For users who only need quick installs, I agree an alias/function is simpler, but my goal with aur-auto is a lightweight tool to search, select, and install AUR packages in one go — kind of a middle ground between typing out git clone … && makepkg … and installing a full AUR helper like yay/paru. It’s not meant to replace yay or paru, just to provide a scriptable, minimal, user-friendly installer for those who want something lighter.

