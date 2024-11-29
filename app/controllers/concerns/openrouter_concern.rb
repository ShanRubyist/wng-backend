require 'openrouter'

module OpenrouterConcern
  extend ActiveSupport::Concern

  included do |base|
  end

  def openrouter_completion(prompt)
    client = Bot::Openrouter.new
    options = {}

    begin
      result = client.handle(prompt, nil, options)
    ensure
    end

    rst = result['choices'][0]['message']['content']
    save_to_db({ output: rst, prompt: prompt, data: result })
    rst
  end

  def save_to_db(options = {})
    ReplicatedCall
      .create(data: options.fetch(:data), output: options.fetch(:output), prompt: options.fetch(:prompt))
  end

  def openrouter_completion2(prompt, first_name, last_name)
    client = Bot::Openrouter.new
    options = {}

    begin
      result = client.handle(prompt, nil, options)
    ensure
    end

    rst = result['choices'][0]['message']['content']
    save_to_db2({ user: current_user, output: rst, prompt: prompt, data: result, first_name: first_name, last_name: last_name })
    rst
  end
  def save_to_db2(options = {})
    user = options.fetch(:user)
    data = options.fetch(:data)
    output = options.fetch(:output)
    prompt = options.fetch(:prompt)
    first_name = options.fetch(:first_name)
    last_name = options.fetch(:last_name)
    model = options.fetch(:model) {''}

    user
      .name_based_generated_logs
      .create(data: data, output: output, prompt: prompt, first_name: first_name, last_name: last_name, model: model)
  end

  module ClassMethods
  end
end
