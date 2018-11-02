class GenresController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/genres/") }

  get '/genres' do
    @genres = Genre.all
    erb :index
  end

  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])

    if @genre
      erb :show
    else
      redirect to '/genres'
    end
  end
end
