class ChangePublisherDefaultValue < ActiveRecord::Migration[5.1]
  def change
      change_column :users, :publisher, :boolean, default: false
  end
end
