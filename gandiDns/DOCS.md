# Home Assistant Add-on: GandiDNS

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Find the "GandiDNS" add-on and click it.
3. Click on the "INSTALL" button.

## How to use

```yaml
api_key: GANDI_API_KEY
domain: my-awesome-domain.rocks
reccords:
  - sub1
  - sub2
```
With this configuration, the add-on will update `sub1.my-awesome-domain.rocks` and `sub2.my-awesome-domain.rocks` dns A RRset record for your domain zone on your Gandi account. If you just want to update `my-awesome-domain.rocks` add `@` as record.


This add-on is not compatible with ipv6 and is theoriticaly useless for ipv6.

