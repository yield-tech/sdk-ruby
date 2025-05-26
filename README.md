# The official Yield SDK for Ruby

## Installation

```sh
gem install yield-sdk
```

## Usage

```ruby
require "yield/sdk"

# for security, never commit the actual key in your code
client = Yield::SDK::Client.new(ENV["YIELD_API_KEY"])

# fetch an existing order
order = client.order.fetch("ord_...")
p order.customer.registered_name

# or create a new one
new_order = client.order.create({
    customer_id: "org_...",
    total_amount: "PHP 1234.50",
    note: "Test order from the Ruby SDK!"
})
```
