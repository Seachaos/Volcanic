class CreateRequestTasks < ActiveRecord::Migration
  def change
    create_table :request_tasks do |t|
      t.string :name
      t.string :url
      t.string :method
      t.string :type

      t.timestamps null: false
    end
  end
end
