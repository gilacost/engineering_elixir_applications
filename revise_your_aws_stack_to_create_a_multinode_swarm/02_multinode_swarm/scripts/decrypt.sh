#!/usr/bin/env bash

# in scripts/decrypt.sh

# get path of secrets/ folder relative to current script
# so script can be run from anywhere
CURRENT_SCRIPT_DIRECTORY=$(dirname "$0")
SECRETS_DIRECTORY="$CURRENT_SCRIPT_DIRECTORY/../secrets"

# decrypt the file and store the output in a variable
decrypted_content=$(sops --decrypt $SECRETS_DIRECTORY/secrets.enc.yaml)

# read each line of decrypted content -
# the text before the ":" is the filename and the text after is the secret
echo "${decrypted_content}" | while IFS=: read -r filename value; do
    # trim any leading space from value
    content=$(echo "$value" | xargs)
    # write the content to the corresponding file in the secrets folder
    echo "${content}" > "$SECRETS_DIRECTORY/${filename}"
done
