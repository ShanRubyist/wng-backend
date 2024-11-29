class CreateNameBasedGeneratedLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :name_based_generated_logs, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :prompt, null: false
      t.string :output
      t.jsonb :data
      t.string :model
      t.timestamps
    end
  end
end