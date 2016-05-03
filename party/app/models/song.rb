class Song
  attr_accessor :song, :title, :artist, :duration
  def initialize(song)
    @song = song

    # process to find spotify ids, etc
    data = $vk.audio.search(q: @song)[1]
    @url = data["url"]
    @title = data["title"]
    @artist = data["artist"]
    @duration = data["duration"]
    $redis.rpush(:songs, self.to_json)
    # push json object to a queue of songs
  end

  def self.find(id)
    return $redis.lindex(:songs, id)
  end
  
  def self.all(start: nil, stop: nil)
        start = 0 if start.nil?
        stop = -1 if stop.nil?
        return $redis.lrange(:songs, start, stop)
  end

end
