# CheshireCatApi

Welcome to CheshireCatApi

The Cheshire Cat AI Framework Client gem is a fundamental innovation for developers interested in exploring and leveraging the capabilities of Large Language Models (LLM) through the Cheshire Cat AI framework. This tool provides simplified access to a wide range of advanced functions, including plugin installation, customization of Large Language Models, the use of Embeddings, and effective management of chat history. With the ability to connect via WebSocket, it facilitates the development of dynamic and interactive dialogues with LLMs, expanding the creative and technical possibilities for developers.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add cheshire_cat_api

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install cheshire_cat_api

## Usage

# WebSocket

```ruby

ws = ClientWs.new(url: "localhost:1865", user: nil)
ws.callback = lambda do |m|
  puts m.data
end
ws.connect 
ws.send_message("hello")
# => {"type":"chat_token","content":"Hello"}
# ...
# => {"type":"chat" ... }
```

```ruby
ws = CheshireCatApi::ClientWs.new(url: "localhost:1865", user: nil, callback: Proc.new { |m| puts m.data } )
ws.connect(message: "hello")
# => {"type":"chat_token","content":"Hello"}
# ...
# => {"type":"chat" ... }
```

# Settings, LLM, Plugin, Embedding, Rabbit Hole

```ruby
cat = CheshireCatApi::Client.new("localhost:1865", "")
```

All Cheshire Cat AI settings
```ruby
cat.settings.index
```
Set Cheshire Cat AI settings
```ruby
cat.settings.create({
      name: "string",
      value: {},
      category: "string",
      setting_id: "483323c4-6bc1-4a53-81a9-b164dcd7da28",
      updated_at: 1_703_001_577
    })
```
Update Cheshire Cat AI settings
```ruby
cat.settings.update({
      name: "string",
      value: {},
      category: "string",
      setting_id: "483323c4-6bc1-4a53-81a9-b164dcd7da28",
      updated_at: 1_703_001_577
    })
```

## Plugin

All Cheshire Cat AI plugins
```ruby
cat.plugins.index
```

Upload Cheshire Cat AI plugin
```ruby
cat.plugins.upload(File.open("path/to/plugin"))
```

Update from url Cheshire Cat AI plugin
```ruby
cat.plugins.update_from_url("https://github.com/example/example")
```

Delete Cheshire Cat AI plugin
```ruby
cat.plugins.delete("example")
```
Toggle Cheshire Cat AI plugin
```ruby
cat.plugins.toggle("example")
```

Show Cheshire Cat AI plugin
```ruby
cat.plugins.show("example")
```

Settings Cheshire Cat AI plugin
```ruby
cat.plugins.settings
```

Update settings Cheshire Cat AI plugin
```ruby
cat.plugins.update_settings("example", { DataSource: "sqlite" })
```

Index llm settings
```ruby
cat.llm.settings
```

Get llm setting
```ruby
cat.llm.setting("example")
```

Update llm setting
```ruby
cat.llm.update_setting("example", { url: "https://www.example.com" })
```

## Embedding

Recall memory
```ruby
cat.memory.recall("example", k: 100)
```

All collections
```ruby
cat.memory.collections
```

Delete all collections
```ruby
cat.memory.delete_collections
```

Delete collection
```ruby
cat.memory.delete_collection("example")
```

Delete point
```ruby
cat.memory.delete_point("collection", "example")
```

Delete all points
```ruby
cat.memory.delete_points("collection")
```

All conversations
```ruby
cat.memory.conversations
```

Delete all conversations
```ruby
cat.memory.delete_conversations
```

Settings embedding
```ruby
cat.embedder.settings
```

Setting embedding
```ruby
cat.embedder.setting("example")
```

Update setting embedding
```ruby
cat.embedder.update_setting("example", { size: 156 })
```
## RABBIT HOLE

Update file for embedding
```ruby
cat.rabbit_hole.update(File.open("path/to/file"))
```

Update url for embedding
```ruby
cat.rabbit_hole.url("https://www.example.com")
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Jhonnyr97/cheshire_cat_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Jhonnyr97/cheshire_cat_api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CheshireCatApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Jhonnyr97/cheshire_cat_api/blob/master/CODE_OF_CONDUCT.md).
