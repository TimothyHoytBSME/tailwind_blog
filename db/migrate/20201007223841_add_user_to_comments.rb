class AddUserToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :user, foreign_key: true
    #Comment.update_all(user_id: 3 )
  end
end
