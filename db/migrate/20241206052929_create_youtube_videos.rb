class CreateYoutubeVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :youtube_videos do |t|
      t.timestamps
    end
  end
end
