# Blackfire
[![Build Status](https://travis-ci.com/boxuk/chassis_blackfire.svg?token=3rRfYiN6sMupp1z6RpzN&branch=master)](https://travis-ci.com/boxuk/chassis_blackfire)

A Chassis extension to install and configure [Blackfire](https://blackfire.io) on your Chassis server.

## Usage
1. Add this extension to your extensions directory `git clone git@github.com:boxuk/chassis_blackfire.git extensions/chassis_blackfire`
2. Ensure your `config.local.yaml` PHP version is set to 5.6 or higher.
3. Ensure you have the following configuration in your `config.local.yaml`

```yaml
blackfire:
    server_id: YOUR_SERVER_ID_HERE
    server_token: YOUR_SERVER_TOKEN_HERE
```

> You can obtain these values from: https://blackfire.io/account/agents

4. Run `vagrant provision`.
