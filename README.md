# dotfiles

tkancf dotfiles

## setup

```bash
git clone --depth 1 https://github.com/tkancf/dotfiles ~/.config/dotfiles
cd ~/.config/dotfiles
chmod +x setup.sh
./setup.sh
brew bundle --file=config/homebrew/Brewfile
```

## Docker development environment

Two Dockerfiles are provided to speed up image builds:

1. `Dockerfile.base` installs Fish, Git, build essentials, the latest Neovim release, bundles the `mise` runtime manager, provisions an OpenSSH server, and creates a passwordless `dev` user whose default shell is Fish.
2. `Dockerfile.dev` extends the base image and simply configures the container to run the bundled SSH daemon.

Build the layered images:

```bash
# Build the base toolchain image
docker build -f Dockerfile.base -t dev-base:latest .

# Build the SSH-enabled development image from the base
docker build -f Dockerfile.dev -t dev-environment:latest --build-arg BASE_IMAGE=dev-base:latest .
```

Run the development container:

```bash
docker run -d \
  --name dev-environment \
  -p 2222:22 \
  dev-environment:latest
```

The container exposes SSH on port 22 (mapped to 2222 above) with the `dev` account configured for passwordless login (press Enter when prompted for a password). The default shell is Fish, and the Neovim binary is available at `/usr/local/bin/nvim`.
