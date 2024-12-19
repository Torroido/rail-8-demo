class CreateYoutubeVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :youtube_videos do |t|
      t.string "title"
      t.string "url"
      t.integer "duration_in_seconds"
      t.string "quality"

      t.timestamps
    end
  end
end
