class AddStateToCoursesUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :courses_users, :state, :string, :default => "not_clicked"
  end
end
