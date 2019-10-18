# Blackfire

A Chassis extension to install and configure [Blackfire](https://blackfire.io) on your Chassis server.

## Usage
1. Add this extension to your extensions directory `git clone git@github.com:BoxUK/chassis-blackfire.git extensions/blackfire`
2. Set your `config.local.yaml` PHP version to 5.6 or higher.
3. Ensure you have the following configuration in your `config.local.yaml`

```yaml
blackfire:
    server_id: YOUR_SERER_ID_HERE
    server_token: YOUR_SERVER_TOKEN_HERE
```

> You can obtain these values from: https://blackfire.io/account/agents

4. Run `vagrant provision`.
