class AddIndexToTicketsRequestNumber < ActiveRecord::Migration[6.1]
  def change
    add_index :tickets, :request_number, unique: true
  end
end
