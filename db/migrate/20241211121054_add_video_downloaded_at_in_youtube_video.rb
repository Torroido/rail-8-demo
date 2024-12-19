class AddVideoDownloadedAtInYoutubeVideo < ActiveRecord::Migration[8.0]
  def change
    add_column :youtube_videos, :downloaded_at, :datetime
  end
end
