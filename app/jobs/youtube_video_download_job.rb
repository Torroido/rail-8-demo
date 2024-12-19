class YoutubeVideoDownloadJob < ApplicationJob
  def perform(youtube_video_id)
    youtube_video = YoutubeVideo.find(youtube_video_id)
    link = youtube_video.url
    url = URI("#{ENV['DOWNLOAD_URL']}/youtube-import")
    headers = { "Content-Type" => "application/json" }
    body = { youtube_url: link }
    response = HTTParty.post(url, headers: headers, body: body.to_json).body

    begin
      download_url = JSON.parse(response)["url"]
      if download_url
        youtube_video.update_column(:download_url, download_url)
      end
    rescue
      nil
    end
  end
end
