class Api::V1::OpenrouterController < ApplicationController
  include OpenrouterConcern

  # before_action :authenticate_user!

  rescue_from RuntimeError do |e|
    render json: { error: e }.to_json, status: 500
  end

  def completion
    gender = params['gender'] || raise('gender can not be empty')
    style = params['style'] || raise('style can not be empty')
    prompt = "Generate 5 #{gender} wizard names in the style of #{style}, with each name having a meaning. Return a valid json object with \"name\", \"meaning\", and \"gender\" fields for each name. Do not include any other text or code block markers."

    response.headers["Content-Type"] = "application/json"
    response.headers["Last-Modified"] = Time.now.httpdate

    render json: {
      names: JSON.load(openrouter_completion(prompt))
    }
  end
end
