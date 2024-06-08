# Setup IDX Platform 🚀
This project streamlines the setup of your IDX development environment. It provides a pre-configured setup and tools to manage SSH keys and Docker-based services, making your IDX experience smoother.

## Features ✨
- **Preconfigured IDX:** An optimized `dev.nix` file for a seamless IDX development experience.
- **SSH Key Management:** Simplified setup of SSH keys for easy interaction with Git repositories (GitHub, GitLab, Bitbucket).
- **Docker Compose Integration:** Streamlined setup and management of development services using Docker Compose.

## Prerequisites 📋
Before you begin, make sure you have:
- **Project IDX Account:** Create one at [https://idx.dev](https://idx.dev). For more information about Project IDX, refer to the official guide: [https://developers.google.com/idx/guides/introduction](https://developers.google.com/idx/guides/introduction)
- **Basic understanding of command line/terminal usage.**

## Installation 🛠️
### Option 1: One-Line Install
```bash
$ curl -fsSL https://raw.githubusercontent.com/sikancil/setup-idx/main/install_setup-idx | bash
```
### Option 2: Manual Install
1. **Clone the repository:**
```bash
git clone --depth 1 https://github.com/your-username/setup-idx.git .setup-idx
./.setup-idx/cmd/setup-idx
```
2. **Run the setup script:**
```bash
$ setup-idx

1) Walkthrough all
2) Preconfigure IDX
3) Only Setup SSH Keys
4) Only Setup Services
5) Update
6) Uninstall
7) Exit
🚦 Please select an option: 
```

## Usage 🚀
You'll be presented with options to:
  - Walkthrough all features
  - Preconfigure IDX only
  - Setup SSH Keys only
  - Setup Services (container some apps) only
  - Update
  - Uninstall
  - Exit
2. **Follow the prompts:** Each script will guide you through the necessary steps and may ask for confirmation before making changes.
3. **Rebuild your IDX Environment (if applicable):** After configuring IDX, go to your Project IDX workspace and **Rebuild the Environment** to apply the changes.

## Updating 🔄
### Option 1: One-Line Update
```bash
curl -fsSL https://raw.githubusercontent.com/sikancil/setup-idx/main/update_setup-idx | bash
```
### Option 2: Manual Update
Run the `setup-idx` command and select **option 5** to update.

## Uninstallation 🗑️
### Option 1: One-Line Uninstall
```bash
curl -fsSL https://raw.githubusercontent.com/sikancil/setup-idx/main/uninstall_setup-idx | bash
```
### Option 2: Manual Uninstall
Run the `setup-idx` command and select **option 6** to uninstall.

## What's Included 📦
  - **Pre-configured `dev.nix` file:** Commonly used optimized settings for IDX.
  - **SSH Key setup scripts:** Scripts to generate and configure SSH keys for various Git providers.
  - **Docker Compose configuration examples:** Templates and guidance for setting up development services.

## Contributing 🤝
Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

## License 📝
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
