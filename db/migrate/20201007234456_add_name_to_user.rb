class AddNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    User.update_all(name: 'Name Here')
  end
end
