class SpotifyController < ApplicationController
  def callback
    host = RSpotify::User.new(request.env['omniauth.auth'])
    @is_nil = true
    unless host.player.nil?
      @is_nil = false
      @is_playing = host.player.playing?
      @currently_playing = host.player.currently_playing if @is_playing
      @display_name = host.display_name
    end
  end
end
