# Build Scripts

This directory contains the scripts that run the majority of the image build process.

## How It Works

The build is controlled by the ``build.sh``.  You'll need to edit it to include the reusable scripts
from ``tr-osforge`` you'll want to use by adding the names of the scripts (sans the ``.sh`` suffix) to the
``OSFORGE_SCRIPTS_TO_USE`` array variable in the script.

## Included Scripts

- ``build.sh`` - Controller script for the build process.
- ``custom.sh`` - Sets up the Flatpaks, Brewfiles, and ``ujust`` scripts that are included on your image.
- ``image-overrides.sh`` - Anything that is specific to this particular image that can't be shared in the ``tr-osforge`` repository.

## Example Scripts

- **`20-onepassword.sh.example`** - Example showing how to install software from third-party RPM repositories (Google Chrome, 1Password)

To use an example script:
1. Remove the `.example` extension
2. Make it executable: `chmod +x build/20-yourscript.sh`
3. The build system will automatically run it in numerical order

## Creating Your Own Scripts

Create numbered scripts for different purposes:

```bash
# 10-build.sh - Base system (already exists)
# 20-drivers.sh - Hardware drivers  
# 30-development.sh - Development tools
# 40-gaming.sh - Gaming software
# 50-cleanup.sh - Final cleanup tasks
```

### Script Template

```bash
#!/usr/bin/env bash
set -oue pipefail

echo "Running custom setup..."
# Your commands here
```

### Best Practices

- **Use descriptive names**: `20-nvidia-drivers.sh` is better than `20-stuff.sh`
- **One purpose per script**: Easier to debug and maintain
- **Clean up after yourself**: Remove temporary files and disable temporary repos
- **Test incrementally**: Add one script at a time and test builds
- **Comment your code**: Future you will thank present you

### Disabling Scripts

To temporarily disable a script without deleting it:
- Rename it with `.disabled` extension: `20-script.sh.disabled`
- Or remove execute permission: `chmod -x build/20-script.sh`

## Execution Order

The Containerfile runs scripts like this:

```dockerfile
RUN /ctx/build/10-build.sh
```

If you want to run multiple scripts, you can:

1. **Modify Containerfile** to run each script explicitly
2. **Create a runner script** that executes all numbered scripts
3. **Use the default** and keep everything in `10-build.sh` (simplest)

## Notes

- Scripts run as root during build
- Build context is available at `/ctx`
- Use dnf5 for package management (not dnf or yum)
- Always use `-y` flag for non-interactive installs
