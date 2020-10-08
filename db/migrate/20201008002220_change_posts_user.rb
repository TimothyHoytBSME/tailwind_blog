class ChangePostsUser < ActiveRecord::Migration[6.0]
  def change
    Post.update_all(user_id: 3)
  end
end
