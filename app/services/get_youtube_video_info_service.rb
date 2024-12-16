require "google/apis/youtube_v3"

class GetYoutubeVideoInfoService
  def initialize(video_id)
    @video_id = video_id
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = ENV["GOOGLE_API_KEY"]
  end

  def call
    details = @youtube.list_videos("snippet", id: @video_id)
    {
      title: details.items.first.snippet.title,
      duration_in_seconds: get_video_duration
    }
  end

  def parse_duration(duration)
    hours = duration.match(/(\d+)H/)&.captures&.first.to_i || 0
    minutes = duration.match(/(\d+)M/)&.captures&.first.to_i || 0
    seconds = duration.match(/(\d+)S/)&.captures&.first.to_i || 0

    hours * 3600 + minutes * 60 + seconds
  end

  def get_video_duration
    response = @youtube.list_videos("contentDetails", id: @video_id)
    video = response.items.first
    if video
      duration = video.content_details.duration
      parse_duration(duration)
    end
  end
end
