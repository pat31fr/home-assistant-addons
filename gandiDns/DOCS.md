# Home Assistant Add-on: GandiDns

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Find the "GandiDns" add-on and click it.
3. Click on the "INSTALL" button.

## How to use

```yaml
api_key: GANDI_API_KEY
domain: my-awesome-domain.rocks
reccords:
  - sub1
  - sub2
```
With this configuration, the add-on will update `sub1.my-awesome-domain.rocks` and `sub2.my-awesome-domain.rocks` dns reccords for your domain zone on your Gandi account. If you just want to update `my-awesome-domain.rocks` add `@` as reccord.