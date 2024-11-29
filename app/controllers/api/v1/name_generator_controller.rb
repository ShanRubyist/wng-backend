class Api::V1::NameGeneratorController < UsageController
  include OpenrouterConcern

  before_action :authenticate_user!, only: [:name_based_generator]

  rescue_from RuntimeError do |e|
    render json: { error: e }.to_json, status: 500
  end

  def name_based_generate
    first_name = params['firstName']
    last_name = params['lastName']
    fail 'illegal name' if first_name.length > 20 || last_name.length > 20

      prompt =-<<DOC
You are a professional magical name generator. Generate 5 unique wizard names by analyzing the linguistic and gender characteristics of the first name "#{first_name}" and last name "#{last_name}".

Generation Guidelines:
1. Gender Inference:
   - Analyze first and last name to determine likely gender
   - Use name databases, cultural name patterns, and linguistic markers
   - If gender is ambiguous, choose a neutral or flexible magical naming approach

2. Name Analysis Features:
   - Syllable count
   - Letter composition
   - Name etymology and potential meaning

3. Wizard Name Generation Strategy:
   - Preserve parts of original name's letters or syllables
   - Create magical names with inferred gender-specific styles
   - Add magical prefixes and suffixes
   - Incorporate elemental or magical themes

4. Creative Requirements:
   - Each name should evoke magical essence
   - Names should connect to original name phonetically, letterwise, or meaningfully
   - Avoid completely random generation

Return Format:
- Generate 5 wizard names
- Return a valid JSON object with "name", "meaning", and "inferred_gender" fields for each name
- Do not include any other text or code block markers

Strictly follow the JSON output requirement.
DOC

      response.headers["Content-Type"] = "application/json"
      response.headers["Last-Modified"] = Time.now.httpdate

      render json: {
        names: JSON.load(openrouter_completion2(prompt, first_name, last_name))
      }
  end
end
