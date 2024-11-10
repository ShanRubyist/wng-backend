require 'openrouter'

module OpenrouterConcern
  extend ActiveSupport::Concern

  included do |base|
  end

  def openrouter_completion(prompt)
    client = Bot::Openrouter.new
    options = {}

    begin
      result = client.handle(prompt, prompt, options)
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

  module ClassMethods
  end
end
