require "cheshire_cat_api"
require "spec_helper"

describe CheshireCatApi::Client do
  subject { CheshireCatApi::Client.new("localhost:1865", "") }
  it "check home" do
    response = {
      "status": "We're all mad here, dear!",
      "version": "x.x.x"
    }
    stub_request(:get, "localhost:1865")
      .to_return(status: 200, body: response.to_json)

    expect(subject.home).to eq(response)
  end

  it "index settings" do
    response = {
      "settings": []
    }
    stub_request(:get, "localhost:1865/settings/")
      .to_return(status: 200, body: response.to_json)

    expect(subject.settings.index).to eq(response[:settings])
  end

  it "create setting" do
    request = {
      name: "string",
      value: {},
      category: "string",
      setting_id: "483323c4-6bc1-4a53-81a9-b164dcd7da28",
      updated_at: 1_703_001_577
    }
    response = {
      settings: request
    }
    stub_request(:post, "localhost:1865/settings/").with(body: request.to_json)
      .to_return(status: 200, body: response.to_json)
    expect(subject.settings.create(request)).to eq(response[:settings])
  end

  it "show setting" do
    response = {
      setting: {
        name: "string",
        value: {},
        category: "string",
        setting_id: "483323c4-6bc1-4a53-81a9-b164dcd7da28",
        updated_at: 1_703_001_577
      }
    }
    stub_request(:get, "localhost:1865/settings/483323c4-6bc1-4a53-81a9-b164dcd7da28/")
      .to_return(status: 200, body: response.to_json)

    expect(subject.settings.show("483323c4-6bc1-4a53-81a9-b164dcd7da28")).to eq(response[:setting])
  end

  it "update setting" do
    response = {
      setting: {
        name: "string3",
        value: {},
        category: "string3",
        setting_id: "483323c4-6bc1-4a53ì-81a9-b164dcd7da28",
        updated_at: 1_703_001_577
      }
    }
    stub_request(:put, "localhost:1865/settings/483323c4-6bc1-4a53-81a9-b164dcd7da28/")
      .to_return(status: 200, body: response.to_json)

    expect(subject.settings.update("483323c4-6bc1-4a53-81a9-b164dcd7da28", response[:setting])).to eq(response[:setting])
  end

  it "index plugins" do
    response = {
      registry: [{
        name: "AIChatSQL",
        version: "0.0.5",
        description: "Discover the future of query processing with AIChatSQL. Harness the unlimited potential of large
          language models (LLM) to execute your queries intuitively and powerfully.
          Revolutionize the way you interact with databases, thanks to artificial intelligence that understands
          natural language and instantly translates your requests into SQL queries.
          Take control in your hands and simplify the data querying process. Welcome to the future of human-machine
          interaction in the database domain with AIChatSQL.",
        author_name: "Nilthon Jhon Rojas Apumayta",
        author_url: "https://www.linkedin.com/in/nilthon-jhon-rojas-apumayta-87634913a/",
        plugin_url: "https://github.com/Jhonnyr97/AIChatSQL",
        tags: "sql, llm, cheshire-cat, postgres, mysql, sqlite, python",
        thumb: "https://raw.githubusercontent.com/Jhonnyr97/AIChatSQL/main/logo.png",
        url: "https://github.com/Jhonnyr97/AIChatSQL"
      }],
      installed: [{
        id: "core_plugin",
        name: "Core CCat",
        description: "The core Cat plugin used to define default hooks and tools. You don't see this plugin in the
              plugins folder, because it is an hidden plugin. It will be used to try out hooks and tools before they become
              available to other plugins. Written and delivered just for you, my furry friend.",
        author_name: "Cheshire Cat",
        author_url: "https://cheshirecat.ai",
        plugin_url: "https://github.com/cheshire-cat-ai/core",
        tags: "core, default, cat",
        thumb: "",
        version: "0.0.2",
        active: true,
        hooks: [
          {
            name: "agent_allowed_tools",
            priority: 0
          },
          {
            name: "agent_fast_reply",
            priority: 0
          },
          {
            name: "before_agent_starts",
            priority: 0
          },
          {
            name: "agent_prompt_instructions",
            priority: 0
          },
          {
            name: "agent_prompt_prefix",
            priority: 0
          },
          {
            name: "agent_prompt_suffix",
            priority: 0
          },
          {
            name: "after_rabbithole_splitted_text",
            priority: 0
          },
          {
            name: "before_rabbithole_insert_memory",
            priority: 0
          },
          {
            name: "before_rabbithole_splits_text",
            priority: 0
          },
          {
            name: "before_rabbithole_stores_documents",
            priority: 0
          },
          {
            name: "rabbithole_instantiates_parsers",
            priority: 0
          },
          {
            name: "after_cat_bootstrap",
            priority: 0
          },
          {
            name: "after_cat_recalls_memories",
            priority: 0
          },
          {
            name: "before_cat_bootstrap",
            priority: 0
          },
          {
            name: "before_cat_reads_message",
            priority: 0
          },
          {
            name: "before_cat_recalls_declarative_memories",
            priority: 0
          },
          {
            name: "before_cat_recalls_episodic_memories",
            priority: 0
          },
          {
            name: "before_cat_recalls_memories",
            priority: 0
          },
          {
            name: "before_cat_recalls_procedural_memories",
            priority: 0
          },
          {
            name: "before_cat_sends_message",
            priority: 0
          },
          {
            name: "cat_recall_query",
            priority: 0
          }
        ],
        tools: [
          {
            name: "get_the_time"
          }
        ]
      }]
    }
    stub_request(:get, "localhost:1865/plugins/")
      .to_return(status: 200, body: response.to_json)

    expect(subject.plugins.index[:registry]).to eq(response[:registry])
    expect(subject.plugins.index[:installed]).to eq(response[:installed])
  end

  it "upload plugin" do
    response = {
      filename: "aichatsql.zip",
      content_type: "application/zip",
      info: "Plugin is being installed asynchronously"
    }

    stub_request(:post, "localhost:1865/plugins/upload/").to_return(status: 200, body: response.to_json)

    expect(subject.plugins.upload(File.open("spec/fixtures/aichatsql.zip", "rb"))).to eq(response)
  end


  it "upload plugin from url" do
    response = {
      info: "Plugin is being installed asynchronously",
      url: "https://github.com/Jhonnyr97/AIChatSQL"
    }

    stub_request(:post, "localhost:1865/plugins/upload/registry").to_return(status: 200, body: response.to_json)

    expect(subject.plugins.upload_from_url("https://github.com/Jhonnyr97/AIChatSQL")).to eq(response)
  end

  it "delete plugin" do
    response = {
      "deleted": "aichatsql"
    }

    stub_request(:delete, "localhost:1865/plugins/aichatsql/").to_return(status: 200, body: response.to_json)

    expect(subject.plugins.delete("aichatsql")).to eq(response)
  end

  it "toggle plugin" do
    response = {
      "info": "Plugin aichatsql toggled"
    }

    stub_request(:put, "localhost:1865/plugins/toggle/aichatsql/").to_return(status: 200, body: response.to_json)

    expect(subject.plugins.toggle("aichatsql")).to eq(response)
  end


end
