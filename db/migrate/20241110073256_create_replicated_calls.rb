class CreateReplicatedCalls < ActiveRecord::Migration[7.0]
  def change
    create_table :replicated_calls, id: :uuid do |t|
      t.string "prompt", null: false
      t.string "output"
      t.jsonb "data"
      t.string "model"
      t.timestamps
    end
  end
end

