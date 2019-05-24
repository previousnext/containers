# Current weather bot

## Running locally

Create a folder for your configuration e.g. `env` and put two files in it like so

```
env
├── botToken
└── clientSigningSecret
```

in botToken put your bot token from the Slack API creds, and put your clientSigningSecret in the other file.

```
docker build . -t larowlan/commitweather
docker run --rm -p 3000:3000 -v $(pwd)/env:/etc/skpr larowlan/commitweather
```
