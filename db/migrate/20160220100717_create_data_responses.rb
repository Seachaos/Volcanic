class CreateDataResponses < ActiveRecord::Migration
  def change
    create_table :data_responses do |t|
      t.string :name
      t.string :value
      t.string :response
      t.string :response_type
      t.string :path
      t.string :type
      t.timestamps null: false
    end
  end
end
