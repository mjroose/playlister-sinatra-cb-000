class SongsController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/songs") }

  get '/songs' do
    @songs = Song.all
    erb :index
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :new
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    if @song
      erb :show
    else
      redirect to '/songs'
    end
  end

  post '/songs' do
    song_name = params["song"]["name"]
    artist_name = params["artist"]["name"]
    genre_ids = params["genres"] || []

    if song_name && artist_name
      @song = Song.new(name: song_name)
      @song.artist = Artist.find_or_create_by(name: artist_name)
    else
      @error_message = "You must enter a song name!"
      @genres = Genre.all
      erb :new
    end

    genre_ids.each do |genre_id|
      genre = Genre.find_by(id: genre_id)
      if genre
        @song.genres << genre
      end
    end

    @song.save

    redirect to "/songs/#{@song.slug}"
  end
end
