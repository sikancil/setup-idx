## Setup IDX Platform
This project streamlines the setup of your IDX development environment, offering a pre-configured setup and tools to manage SSH keys and Docker-based services.

### Features
- **Preconfigured IDX:**  Provides an optimized `dev.nix` file for a smooth IDX development experience.
- **SSH Key Management:**  Simplifies the setup of SSH keys for seamless interaction with Git repositories (GitHub, GitLab, Bitbucket).
- **Docker Compose Integration:**  Facilitates the setup and management of development services using Docker Compose.

### Prerequisites
Before you begin, ensure you have the following:
- **Project IDX Account:** If you don't have one, you can create it at [https://idx.dev](https://idx.dev). For more information about Project IDX, please refer to the official guide: [https://developers.google.com/idx/guides/introduction](https://developers.google.com/idx/guides/introduction)
- **Basic understanding of command line/terminal usage.**

### How to Use
1. **Install**:
  - Clone this repository:
```bash
git clone --depth 1 https://github.com/your-username/setup-idx.git .setup-idx && ./.setup-idx/cmd/setup-idx
```
  - Run this script:
```bash
curl -fsSL https://raw.githubusercontent.com/sikancil/setup-idx/main/install.sh | bash
```
2. **Run the setup script:** Run the main script and follow the prompts to select the features you want to configure:
```bash
./setup-idx/cmd/index.sh
```
```
You can choose to:
  - Walkthrough all features
  - Preconfigure IDX only
  - Setup SSH Keys only
  - Setup Services (Docker Compose) only
  - Exit
```

3. **Follow the prompts:** Each script will guide you through the necessary steps and may ask for confirmation before making changes.
4. **Rebuild your IDX environment (if applicable):** After configuring IDX, go to your Project IDX workspace and rebuild the environment to apply the changes.

### What's Included
- **Pre-configured `dev.nix` file:**  Commonly use to optimized settings for IDX.
- **SSH Key setup scripts:**  Scripts to generate and configure SSH keys for various Git providers.
- **Docker Compose configuration examples:**  Templates and guidance for setting up development services.

### Contributing
Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

### License
This project is licensed under the [MIT License](LICENSE).
