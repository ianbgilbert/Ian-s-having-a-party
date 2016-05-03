class SongsController < ApplicationController
  def index
  end

  def create
    song = Song.new(params[:data])
    render plain: song.to_json
  end

  def new
    @songs = Song.all.reverse
  end
end
