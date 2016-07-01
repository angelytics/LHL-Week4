helpers do
  def logged_in?
    session[:id] != ''
  end

  def get_user
    if logged_in?
      return User.find(session[:id])
    end
  end

  def has_reviewed?(track)
    !Review.where("user_id = ? AND track_id = ?", get_user.id, track.id).first.nil?
  end
end

get '/' do
  redirect '/tracks'
end

get '/login' do
  @curr_page = :login
  @user = User.new

  erb :login
end

post '/login' do
  @user = User.where("email = ? AND password = ?", params[:email], params[:password]).first

  if @user
    session[:id] = @user.id
    redirect '/'
  else
    erb :login
  end
end

get '/users/new' do
  @curr_page = :signup
  @user = User.new

  erb :'users/new'
end

post '/users/new' do
  @user = User.new(email: params[:email], user_name: params[:user_name], password: params[:password])

  if @user.save
    redirect '/login'
  else
    erb :'users/new'
  end
end

get '/logout' do
  session[:id] = ''
  redirect '/login'
end

get '/tracks' do
  @curr_page = :home
  @tracks = Track.order(upvotes: :desc)
  erb :'tracks/index'
end

get '/tracks/new' do
  @curr_page = :new
  @track = Track.new

  erb :'tracks/new'
end

get '/tracks/find' do
  @curr_page = :find
  @track = Track.where(title: params[:title]).first

  @title = params[:title]
  
  if @track
    redirect "/tracks/#{@track.id}"
  else
    erb :'tracks/find'
  end
end

get '/tracks/:id' do
  begin
    @track = Track.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    @track = nil
  end

  @id = params[:id]

  erb :'tracks/show'
end

get '/tracks/:id/upvote' do
  unless logged_in?
    redirect '/tracks'
    return
  end
  
  @vote = Vote.new(track_id: params[:id], user_id: get_user.id)

  if @vote.save
    redirect '/tracks'
  else
    erb :'tracks/upvote'
  end
end

post '/tracks/:id/review' do
  @track = Track.find(params[:id])
  @review = @track.reviews.new(title: params[:title], content: params[:content], score: params[:score], user_id: get_user.id)

  if @review.save
    redirect "/tracks/#{params[:id]}"
  else
    @id = params[:id]

    erb :'tracks/show'
  end
end

delete '/tracks/:id/review' do
  @track = Track.find(params[:id])
  @review = @track.reviews.find_by_user_id(get_user.id)

  if @review.destroy
    redirect "/tracks/#{params[:id]}"
  else
    erb :'tracks/show'
  end
end

post '/tracks/new' do
  @track = Track.new(title: params[:title], author: params[:author], url: params[:url], user_id: get_user.id)

  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end

end