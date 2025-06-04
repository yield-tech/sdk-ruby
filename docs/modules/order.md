[*← Return to index*](../index.md)

Order module
============

**Endpoints:**
- ![query](https://img.shields.io/badge/QUERY-green) [`fetch(id)`](#-fetchid)
- ![command](https://img.shields.io/badge/COMMAND-orange) [`create(params)`](#-createparams)

**Objects:**
- [`Order`](#order)
- [`OrderStatus`](#orderstatus)
- [`OrderCustomerInfo`](#ordercustomerinfo)


Endpoints
---------

### ![query](https://img.shields.io/badge/QUERY-green) `fetch(id)`

Provides information about the order specified.

```ruby
order = client.order.fetch(id)
```

**Returns:** [Order](#order)

**Parameters:**

- `id`: `String` — The ID of the order.


### ![command](https://img.shields.io/badge/COMMAND-orange) `create(params)`

Creates a new order.

```ruby
params = { field: value, ... }
order = client.order.create(params)
```

**Returns:** [`Order`](#order) — The newly created order.

**Parameters:**

- `params`: `Hash` — See the fields right below.

| Field          | Required? | Type        | Description                                                                    |
| -------------- | --------- | ----------- | ------------------------------------------------------------------------------ |
| `customer_id`  | Required* | `String`    | The (Yield) customer ID that this order will belong to.                        |
| `total_amount` | Required  | `MoneyLike` | The total amount of the order.                                                 |
| `note`         | Required* | `String`    | A note shown to the customer during checkout, such as details about the order. |

\* These fields may become optional in a future release.


Objects
-------

### `Order`

| Field           | Type                                               | Description                                                                                   |
| --------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `id`            | `String`                                           | The ID of the order.                                                                          |
| `order_number`  | `String`                                           | The order number.                                                                             |
| `status`        | [`OrderStatus`](#orderstatus)                      | The status of the order.                                                                      |
| `customer`      | [`OrderCustomerInfo`](#ordercustomerinfo) \| `nil` | The customer this order belongs to.                                                           |
| `date`          | `Date`                                             | The date of the order.                                                                        |
| `total_amount`  | `Money`                                            | The total amount of the order.                                                                |
| `note`          | `String` \| `nil`                                  | A note shown to the customer during checkout, such as details about the order.                |
| `payment_link`  | `String` \| `nil`                                  | The payment link for the customer to confirm this order. May be `nil` if no longer available. |
| `creation_time` | `Time`                                             | The timestamp when this order was created.                                                    |


### `OrderStatus`

| Value        | Description                                                                             |
| ------------ | --------------------------------------------------------------------------------------- |
| `:pending`   | The initial status for newly created orders. The customer has yet to confirm the order. |
| `:confirmed` | The customer has confirmed the order.                                                   |
| `:fulfilled` | The order has been marked as fulfilled.                                                 |
| `:cancelled` | The order has been cancelled.                                                           |


### `OrderCustomerInfo`

| Field             | Type              | Description                                   |
| ----------------- | ----------------- | --------------------------------------------- |
| `id`              | `String`          | The ID of the customer.                       |
| `registered_name` | `String`          | The official registered name of the customer. |
| `trade_name`      | `String` \| `nil` | The trade name of the customer.               |
| `customer_code`   | `String` \| `nil` | The customer code assigned to this customer.  |
