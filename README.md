Yield SDK for Ruby [![Gem Version](https://img.shields.io/gem/v/yield-sdk)](https://rubygems.org/gems/yield-sdk)
==================

The official [Yield](https://www.paywithyield.com) SDK for Ruby.


Documentation
-------------

- [API reference](https://github.com/yield-tech/sdk-ruby/blob/main/docs/index.md)


Installation
------------

```sh
gem install yield-sdk
```


Usage
-----

```ruby
require "yield/sdk"

# For security, don't save the actual key in your code or repo
client = Yield::SDK::Client.new(ENV.fetch("YIELD_API_KEY"))

# Fetch an existing order
order = client.order.fetch("ord_...")
p order.customer.registered_name

# Or create a new one
new_order = client.order.create({
  customer_id: "org_...",
  total_amount: "PHP 1234.50",
  note: "Test order from the Ruby SDK!"
})
```

For more details, check out our [API reference](https://github.com/yield-tech/sdk-ruby/blob/main/docs/index.md).
