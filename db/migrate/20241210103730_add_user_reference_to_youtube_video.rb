class AddUserReferenceToYoutubeVideo < ActiveRecord::Migration[8.0]
  def change
    add_reference :youtube_videos, :user, foreign_key: true
  end
end
