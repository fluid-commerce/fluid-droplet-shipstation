class CreateIntegrationSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :integration_settings do |t|
      t.references :company, null: false, foreign_key: true
      t.string :token
      t.boolean :enabled, default: false
      t.jsonb :settings, default: {}

      t.timestamps
    end
  end
end
