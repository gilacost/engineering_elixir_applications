# Use a base image with support for both Windows and Unix-based systems
FROM mcr.microsoft.com/windows/servercore:ltsc2019 AS builder

# Install Chocolatey and Git
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); \
  choco install -y git;

# Copy the install script
COPY install.ps1 C:\\install.ps1

# Run the install script
RUN powershell -Command "C:\\install.ps1"

# Stage 2: Runtime environment
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set user and working directory
USER ContainerAdministrator
WORKDIR C:\\Users\\ContainerAdministrator

# Copy installed tools from the builder stage
COPY --from=builder C:\\Users\\ContainerAdministrator\\.asdf C:\\Users\\ContainerAdministrator\\.asdf

# Set environment variables
ENV ASDF_DIR C:\\Users\\ContainerAdministrator\\.asdf
ENV ASDF_PATH C:\\Users\\ContainerAdministrator\\.asdf\\asdf.ps1

# Source asdf in the user's profile
RUN Add-Content $PROFILE '. C:\\Users\\ContainerAdministrator\\.asdf\\asdf.ps1'

# Copy .tool-versions and install required versions
COPY .tool-versions 'C:\\'

# Install required versions
RUN Get-Content .\\tool-versions | ForEach-Object { & $env:ASDF_DIR\\bin\\asdf install $_ }

# Entry point
CMD ["powershell"]
