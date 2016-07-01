# Homepage (Root path)
configure do

enable :sessions
end


def liked?(music_obj) 
user_id = User.find_by(username:request.cookies["music_app"]).id
if Like.exists?(user_id:user_id)
	puts Like.where(user_id:user_id).pluck(:music_id).include? music_obj.id  
	Like.where(user_id:user_id).pluck(:music_id).include? music_obj.id
else
	false
end
end

get '/music' do
	halt 401, 'illegal user' if request.cookies["music_app"].nil?
	@musics = Music.all 
	erb :index
end

get '/' do
	 if request.cookies["music_app"].nil?
	erb :login
	 else
		@music = Music.all
		 erb :index
	 end
end

post '/login' do
	# check password here
	if User.check_crediential(params[:username],params[:password])
		@failed = false
		response.set_cookie("music_app", value:params[:username])
		redirect '/music'
	else
		@failed = true
		erb :login
	end
end

get '/logout' do
		response.delete_cookie "music_app"
		erb:login
end
get '/register' do
	erb:register
end
post '/register' do
	@user = User.new(
		username: params[:username],
		password: params[:password],
		email: params[:email],
		full_name: params[:fullname])
		if @user.save
			redirect '/music'
		else
			erb :register
		end
end

get '/music/new' do
	halt 401, 'illegal user' if request.cookies["music_app"].nil?
	erb :new
end

post '/music/new' do
	username = request.cookies["music_app"]
	@music = Music.new(
		title: params[:title],
		author: params[:author],
		url: params[:url],
		user_id: User.find_by(username:username).id)
		if @music.save
			redirect '/music'
		else
			erb :new
		end
end

get '/music/:id/like' do
	username = request.cookies["music_app"]
	unless liked?(Music.find(params[:id]))
		#User Deliked - Delete Liked table entry
		Like.create(user_id:User.find_by(username:username).id,music_id:params[:id])
	else
		#User liked - create Liked table entry
		Like.where(user_id:User.find_by(username:username).id).where(music_id:params[:id]).delete_all
	end
	redirect '/music'
end

get '/music/:id' do
	halt 401, 'illegal user' if request.cookies["music_app"].nil?
	@music = Music.find(params[:id])
	erb :show
end
