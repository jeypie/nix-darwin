# 📦 Nix Darwin Setup Guide

Effortlessly manage your macOS configuration with Nix Darwin.
Follow the commands below to set up, update, or clean up your system.

---

## 🚀 Setup and Rebuild

Use the following command to initiate your macOS configuration with the specified flake:

```bash
nix run nix-darwin -- switch --flake ~/code/repos/drackthor/nix-darwin
```

Afterwards, you can use this command for the same purpose:

```bash
darwin-rebuild switch --flake ~/code/repos/drackthor/nix-darwin
```

---

## 🧹 Garbage Collection

To free up space by removing unused Nix store files, run:

```bash
nix-store --gc
```

---

### 🛠 Additional Notes

- Make sure your flake repository is up-to-date before running these commands.
- Always back up your configuration if you're making significant changes.
