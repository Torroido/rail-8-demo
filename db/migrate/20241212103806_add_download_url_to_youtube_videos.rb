class AddDownloadUrlToYoutubeVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :youtube_videos, :download_url, :string
  end
end
