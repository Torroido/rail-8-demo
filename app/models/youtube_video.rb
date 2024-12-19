class YoutubeVideo < ApplicationRecord
  belongs_to :user

  after_create_commit do
    YoutubeVideoDownloadJob.perform_later(self)
  end
end
