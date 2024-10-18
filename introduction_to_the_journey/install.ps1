# Install asdf
if (!(Test-Path $env:ASDF_DIR)) {
    git clone --depth 1 https://github.com/asdf-vm/asdf.git $env:ASDF_DIR --branch v0.10.2
    Add-Content $PROFILE ('. ' + $env:ASDF_DIR + '\\asdf.ps1')
}

# Install plugins
$plugins = @("github-cli", "packer", "terraform", "awscli", "elixir", "erlang", "postgres", "jq")
foreach ($plugin in $plugins) {
    & $env:ASDF_DIR\\bin\\asdf plugin-add $plugin
}

Write-Host "Installation complete. Please restart your terminal or source your profile file."

