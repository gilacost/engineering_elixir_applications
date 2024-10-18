creation_rules:
  - path_regex: secrets/.*$
    key_groups:
      - age:
          - "${age_public_key}"
