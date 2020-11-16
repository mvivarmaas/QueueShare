class SpotifyController < ApplicationController
  def callback
    @host = RSpotify::User.new(request.env['omniauth.auth'])
    seeds = @host.top_tracks(limit: 5)
    @tracks = RSpotify::Recommendations.generate(seed_tracks: seeds.map(&:id)).tracks
    @is_nil = true
    unless @host.player.nil?
      @is_nil = false
      @is_playing = @host.player.playing?
      @currently_playing = @ost.player.currently_playing if @is_playing
      @display_name = @host.display_name
    end
  end

  def playlist
    playlist = @host.create_playlist!('QueueShare')
    playlist.add_tracks!(@tracks)
  end
end

