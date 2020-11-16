class SpotifyController < ApplicationController
  def callback
    @host = RSpotify::User.new(request.env['omniauth.auth'])
    seeds = @host.top_tracks(limit: 5)
    @tracks = RSpotify::Recommendations.generate(seed_tracks: seeds.map(&:id)).tracks
    playlist = @host.create_playlist!('A Surprise From QueueShare', public: false)
    playlist.add_tracks!(@tracks)
    @is_nil = true
    unless @host.player.nil?
      @is_nil = false
      @is_playing = @host.player.playing?
      @currently_playing = @host.player.currently_playing if @is_playing
      @display_name = @host.display_name
    end
  end
end

