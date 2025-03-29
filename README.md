# 🚀 My Nix Configuration

## 📌 Overview

This is my personal Nix configuration, designed to be **modular** and **easy to manage** using Home Manager. It organizes configurations into categories and loads them dynamically.

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
│   ├── 📁 cli
│   │   ├── 📄 atuin.nix
│   │   ├── 📄 bat.nix
│   │   ├── 📄 carapace.nix
│   │   ├── ... (more CLI configs)
│   │
│   ├── 📁 gui
│   │   ├── 📄 aerospace.nix
│   │   ├── 📄 ghostty.nix
│   │   ├── ... (more GUI configs)
│   │
│   ├── 📁 shell
│   │   ├── 📄 fish.nix
│   │   ├── ... (more shell configs)
│   │
│   ├── 📄 aliases.nix
│   ├── 📄 default.nix
│   ├── 📄 env.nix
│   ├── 📄 packages.nix
```

---

## 🛠️ Installation & Usage

### Install Everything (Recommended: [`Determinate Nix`](https://github.com/DeterminateSystems/nix-installer#install-nix))

> **Note:** Update your `username` and `hostname` in [`flake.nix`](./nix/flake.nix).

```bash
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/dotfiles/nix
```

### Rebuild & Apply Changes

```bash
darwin-rebuild switch --flake ~/dotfiles/nix
```

---

## ⚙️ Dynamic Configuration

### 📜 About [`default.nix`](./home/default.nix)

The [`default.nix`](./home/default.nix) file in [`./home/`](./home/) is a key component of my configuration, automatically importing all Home Manager modules to keep the setup clean and flexible. It:

- **Dynamically imports** all `.nix` files in [`./home/`](./home/), eliminating the need to list them manually.
- **Supports modularity**, making it easy to manage different configurations for CLI, GUI, and shell programs.
- **Simplifies enabling/disabling** programs in [`home.nix`](./home/home.nix).

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

This allows all `.nix` files inside [`./home/`](./home/) to be automatically loaded, reducing the need for manual imports.

---

## 🎛️ Customization

### Enabling/Disabling Modules
By default, all modules in [`./home/`](./home/) are enabled. To disable a specific module, set its `enable` option to `false` in [`home.nix`](./home/home.nix):

```nix
{
  neovim.enable = false;
}
```

This prevents Home Manager from installing unnecessary packages while keeping configurations neat.

---

## 🔥 Why This Setup?

✅ **Modular** – Organizes configs into categories.

✅ **Dynamic** – Automatically loads `.nix` files from [`./home/`](./home/).

✅ **Scalable** – Easy to expand and modify.

---

This keeps my Nix setup clean and efficient. 🚀

