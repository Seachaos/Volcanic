class CreateRequestTasks < ActiveRecord::Migration
  def change
    create_table :request_tasks do |t|
      t.string :name
      t.string :url
      t.string :method
      t.string :type
      t.string :responseType
      t.string :dataType
      t.text :data
      t.timestamps null: false
    end
  end
end
