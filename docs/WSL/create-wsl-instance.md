# Create WSL Instance from Base Image

## Prerequisites

* WSL Windows feature installed
* Exported base image as per [base image setup](./create-wsl-base-image.md)

## 1. Import Base Image

Open a command prompt and execute the following command, replacing the `<DISTRO>`, `<NAME>` with whatever you want to call the instance.

```bat
wsl --import <NAME> %LOCALAPPDATA%\Packages\<NAME> <BASE_IMAGE_PATH>

wsl -d <NAME>
```
