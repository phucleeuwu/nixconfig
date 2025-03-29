# 🚀 My Nix Configuration

## 📌 Overview

This is my personal Nix configuration, designed to be **modular** and **easy to manage** using Home Manager. It organizes configurations into categories and loads them dynamically.

---

## 📂 Structure

```
📦 nix-config/
├── 📁 programs
│   ├── 📂 cli
│   ├── 📂 gui
│   ├── 📂 shell
│
├── 📁 services
├── 📁 home
│   ├── default.nix  # Dynamically loads all home modules
│   ├── home.nix
│   ├── packages.nix
│   ├── env.nix
│   ├── aliases.nix
```

---

## 🛠️ Installation & Usage

### Install Everything (Recommend [`Determinate Nix`](https://github.com/DeterminateSystems/nix-installer#install-nix))

> **Note:** Update your `username` and `hostname` in [`flake.nix`](./nix/flake.nix).

```bash
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/dotfiles/nix
```

### Rebuild & Apply Changes

```bash
darwin-rebuild switch --flake ~/dotfiles/nix
```

> **Disabling Specific Nix Module**: set the corresponding module’s `enable` option to `false` in [`home.nix`](./nix/home.nix)

---

## ⚙️ Dynamic Configuration

The `./home/default.nix` file automatically imports all Home Manager modules, keeping the setup clean and flexible.

### 🔍 How It Works

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

This allows all `.nix` files inside `./home/` to be automatically loaded, reducing the need for manual imports.

---

## 📜 About `default.nix`

The `default.nix` file in `./home/` is a key component of my configuration. It:

- **Dynamically imports** all `.nix` files in `./home/`, eliminating the need to list them manually.
- **Supports modularity**, making it easy to manage different configurations for CLI, GUI, and shell programs.
- **Simplifies enabling/disabling** programs in `home.nix`.

Example:
```nix
{
  aerospace.enable = false;
  neovim.enable = false;
}
```
This prevents Home Manager from installing unnecessary packages while keeping configurations neat.

---

## 🎛️ Customization

Disable programs in `home.nix`:
```nix
{
  neovim.enable = false;
}
```

---

## 🔥 Why This Setup?

✅ **Modular** – Organizes configs into categories.

✅ **Dynamic** – Automatically loads `.nix` files from `./home/`.

✅ **Scalable** – Easy to expand and modify.

---

This keeps my Nix setup clean and efficient. 🚀

