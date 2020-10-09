class AddUserToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, foreign_key: true
    Post.update_all(user_id: 3 )
  end
end
