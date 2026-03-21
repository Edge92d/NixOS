Choso-Nix 🩸
A custom NixOS + Flake configuration optimized for the ThinkPad T480. Featuring a visual aesthetic inspired by Choso, synchronized via Pywal.

🖥️ System Specs
Host: Lenovo ThinkPad T480

OS: NixOS (Flake-enabled)

WM: Hyprland

Terminal: Kitty

Theme: Choso-inspired (#A61414 & #4B7E9B)

🚀 Quick Start
1. Clone the Configuration
Bash
git clone https://github.com/Edge92d/NixOS.git ~/nixos-dotfiles
cd ~/nixos-dotfiles
2. Apply System Changes
To rebuild the system using the specific edge-nixos output:

Bash
sudo nixos-rebuild switch --flake .#edge-nixos
3. Apply User Changes (Home Manager)
If you only modified home.nix or user-level configs:

Bash
home-manager switch --flake .
🛠️ Maintenance Workflow
Since this is a Git-tracked Flake, Nix will not "see" new files unless they are staged in Git.

To add a new configuration file:

Create the .nix file.

Run git add . (Crucial: the rebuild will fail if the file isn't tracked).

Run sudo nixos-rebuild switch --flake .#edge-nixos.

To update the flake.lock (update all packages):

Bash
nix flake update
sudo nixos-rebuild switch --flake .#edge-nixos
🎨 Visuals & Keybinds
Colors: Managed via Pywal (Choso Palette).

Launcher: Rofi (customized styles in .config/rofi).

Terminal: Tmux with custom 3-pane layout (Neovim/Gemini focus).

Calendar: Google Calendar sync via calcure.

📂 File Structure
flake.nix: The entry point for the entire configuration.

configuration.nix: Core system settings and hardware-level tweaks.

home.nix: User-specific environment, Git, and app configs.

hardware-configuration.nix: Machine-specific hardware scans.

One Last Tip
Since you're pushing this to a public repo, just double-check your home.nix or configuration.nix to make sure you didn't accidentally leave a Private Google Calendar URL or hashed password in plain text before your next commit!

How's the Hyprland animation speed feeling on the T480 hardware with the new setup?
