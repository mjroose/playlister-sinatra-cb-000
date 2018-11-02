class ArtistsController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/artists/") }

  get '/artists' do
    @artists = Artist.all
    erb :index
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])

    if @artist
      erb :show
    else
      redirect to '/artists'
    end
  end
end
