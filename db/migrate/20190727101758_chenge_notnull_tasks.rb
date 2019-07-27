class ChengeNotnullTasks < ActiveRecord::Migration[5.2]
  def up
    change_column_null :tasks, :title, false
    change_column_null :tasks, :content, false
  end

  def down
    change_column_null :tasks, :title, true
    change_column_null :tasks, :content, true
  end
end
