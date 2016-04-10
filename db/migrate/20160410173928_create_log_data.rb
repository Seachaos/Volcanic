class CreateLogData < ActiveRecord::Migration
  def change
    create_table :log_data do |t|
      t.string :log_type
      t.string :tag
      t.string :msg
      t.string :path
      t.string :raw
      t.timestamps null: false
    end
  end
end
