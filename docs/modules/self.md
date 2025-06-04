[*← Return to index*](../index.md)

Self module
===========

**Endpoints:**
- ![query](https://img.shields.io/badge/QUERY-green) [`info`](#-info)

**Objects:**
- [`SelfInfo`](#selfinfo)
- [`SelfOrganizationInfo`](#selforganizationinfo)


Endpoints
---------

### ![query](https://img.shields.io/badge/QUERY-green) `info`

Provides information about the API key used to call this endpoint.

```ruby
info = client.self.info
```

**Returns:** [`SelfInfo`](#selfinfo)

**Parameters:** None


Objects
-------

### `SelfInfo`

| Field          | Type                                            | Description                           |
| -------------- | ----------------------------------------------- | ------------------------------------- |
| `id`           | `String`                                        | The ID of the API key.                |
| `name`         | `String`                                        | Name of the API key.                  |
| `organization` | [`SelfOrganizationInfo`](#selforganizationinfo) | The organization this key belongs to. |


### `SelfOrganizationInfo`

| Field             | Type              | Description                                       |
| ----------------- | ----------------- | ------------------------------------------------- |
| `id`              | `String`          | The ID of the organization.                       |
| `registered_name` | `String`          | The official registered name of the organization. |
| `trade_name`      | `String` \| `nil` | The trade name of the organization.               |
