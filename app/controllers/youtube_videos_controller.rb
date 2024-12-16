class YoutubeVideosController < ApplicationController
  before_action :set_youtube_video, only: [ :destroy, :download ]
  def index
    @youtube_videos = @current_user.youtube_videos
  end

  def new
  end

  def create
    video_url = youtube_videos_params["url"]

    video_id = extract_video_id(video_url)
    @youtube_video = YoutubeVideo.new(youtube_videos_params)
    if @youtube_video.save!
      details = GetYoutubeVideoInfoService.new(video_id).call
      @youtube_video.update(details)
      redirect_to user_path(@current_user), notice: "Please wait till the video is saved"
    else
      redirect_to new_user_youtube_video_path, alert: "Try another URL."
    end
  end

  def destroy
    if @youtube_video
      if @youtube_video.destroy
        message = "Video was successfully deleted"
      else
        message = "There was an error deleting the video"
      end
    else
      message = "YouTube video not found"
    end
    flash[:error] = message
    redirect_to user_path(@current_user)
  end

  def download
    file = Tempfile.new
    filename = @youtube_video.title
    file.write(Down.download("https://rr5---sn-ci5gup-civl.googlevideo.com/videoplayback?expire=1734090195&ei=c8lbZ62oD6uS4t4Pzvmv4AM&ip=2401%3A4900%3A8820%3Acb3f%3A3599%3A3122%3A6ec1%3A88bf&id=o-AGaH5oGUOshY9eBaBm_T9ctDp9fT-XeNeR0Bh-dDV8Ar&itag=248&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1734068595%2C&mh=jP&mm=31%2C29&mn=sn-ci5gup-civl%2Csn-ci5gup-cvhk&ms=au%2Crdu&mv=m&mvi=5&pcm2cms=yes&pl=47&rms=au%2Cau&initcwndbps=1627500&bui=AfMhrI-miYk1Dy848NDGf9HTzOMFz0ZoScCosfMrFFQppFCM3hpUE45hwRaBpQ3xavkKQj-rU2BWq96C&spc=x-caULI4zQYflwTo-08cpQQi61XoJeLLGd8c8NHXM_whO72ESg&vprv=1&svpuc=1&mime=video%2Fwebm&rqh=1&gir=yes&clen=4236220&dur=62.120&lmt=1729144387564508&mt=1734068239&fvip=1&keepalive=yes&fexp=51326932%2C51335594%2C51347747&c=IOS&txp=5535434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRgIhALYk7AOZEIGO_XiaybWpYjKC7ljqaWPKDS1MrFTOySRGAiEAiD9RYfABgELA6KUi2Nx1kCEFYPKKOOEmlC64oYBl5hs%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpcm2cms%2Cpl%2Crms%2Cinitcwndbps&lsig=AGluJ3MwRQIhAPgHAA_qS-RNaSwTNIdrHcwbbN1Js48AaBPf7aS0BEK9AiByxUIe8GXNDjB6MT8PnzkNEPhM65wrBJMIbnwirZus3w%3D%3D"))

    send_data file.read, filename: filename, type: "video/webm", disposition: "attachment"
  end

  private
  def youtube_videos_params
    params.require(:youtube_video).permit(:url, :quality, :user_id)
  end

  def extract_video_id(url)
    url.match(/(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|live\/|.*[?&]v=))([^&\n?#]+)/)[1]
  end

  def set_youtube_video
    @youtube_video = YoutubeVideo.find(params[:youtube_video_id])
  end
end
