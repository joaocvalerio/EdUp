class AddPublisherToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :publisher, :boolean
  end
end
