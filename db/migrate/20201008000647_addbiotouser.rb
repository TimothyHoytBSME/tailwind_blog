class Addbiotouser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bio, :string
    User.update_all(bio: 'About me.')
  end
end
