class AddColumnExpiredAt < ActiveRecord::Migration[5.2]
  def change
    add_column:tasks,:expired_at,:datetime, null:false

  end
end
