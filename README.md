# 🚀 My Nix Configuration

## 📌 Overview

A modular and easy-to-manage Nix configuration using Home Manager. Configurations are categorized and loaded dynamically.

### 📜 A **Better Way** to Use Home Manager

[`default.nix`](./home/default.nix) automatically imports all Home Manager modules, keeping the setup clean and flexible:

- **Auto-loads** all `.nix` files in [`./home/`](./home/), no manual imports needed.
- **Modular** structure for managing CLI, GUI, and shell programs.
- **Easy toggling** of programs in [`home.nix`](./home.nix).

#### 🔍 How It Works

```nix
{ config, pkgs, lib, ... }:
let
  importModules = dir:
    let files = builtins.attrNames (builtins.readDir dir);
    in map (file: dir + "/${file}") (builtins.filter (file: builtins.match ".*\.nix" file != null) files);

  homeModules = importModules ./home;

in {
  imports = homeModules;
}
```

This loads all `.nix` files inside [`./home/`](./home/) automatically.

---

## 🛠️ Installation & Usage

### Install Everything ([`Determinate Nix`](https://github.com/DeterminateSystems/nix-installer#install-nix) recommended)

> **Note:** Update your `username` and `hostname` in [`flake.nix`](./nix/flake.nix).

```bash
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/dotfiles/nix
```

### Rebuild & Apply Changes

```bash
darwin-rebuild switch --flake ~/dotfiles/nix
```

---

## 📂 Structure

```
📦 nix-config/
├── 📄 flake.nix
├── 📄 home.nix
├── 📄 stylix.nix
├── 📁 darwin
│   ├── 📄 configuration.nix
│   ├── 📄 home.nix
│   ├── 📄 system.nix
│
├── 📁 home
│   ├── 📁 cli (CLI programs)
│   ├── 📁 gui (GUI applications)
│   ├── 📁 shell (Shell environments)
│   ├── 📄 aliases.nix
│   ├── 📄 default.nix
│   ├── 📄 env.nix
│   ├── 📄 packages.nix
```

---

## 🎛️ Customization

### Enable/Disable Modules
All modules in [`./home/`](./home/) are enabled by default. Disable a module in [`home.nix`](./home.nix):

```nix
#example:
neovim.enable = false;
```

---

## 🔥 Why This Setup?

✅ **Modular** – Organized by category.

✅ **Automatic** – Loads all `.nix` files from [`./home/`](./home/).

✅ **Scalable** – Easy to modify and expand.

---

This keeps my Nix setup clean and efficient. 🚀

