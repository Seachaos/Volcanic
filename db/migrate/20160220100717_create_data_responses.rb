class CreateDataResponses < ActiveRecord::Migration
  def change
    create_table :data_responses do |t|
      t.string :name
      t.string :value
      t.text :response
      t.string :response_type
      t.string :path
      t.timestamps null: false
    end
  end
end
