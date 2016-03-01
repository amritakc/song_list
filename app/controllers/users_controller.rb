class UsersController < ApplicationController

	def index
	end

	def create_user
 		if params[:password2] == params[:password]
			@new_user = User.create(name:params[:name],username: params[:username],email: params[:email], password:params[:password])
			if @new_user.invalid? 
				flash[:error] = @new_user.errors.full_messages
				redirect_to '/main'
			else
				@users = User.last
				session[:user_id] = @users.id
				redirect_to '/songs'
			end
		else
			flash[:errors] = "passwords don't match"
			redirect_to '/main'
		end
	end	

	def create_returning_user
		@user = User.find_by(email: params[:email])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect_to '/songs'
		else
			flash[:error] = ["Invalid Login"]
			redirect_to '/main' 
		end
	end

	def show
		@user = User.find(session[:user_id])
		@all_songs = Song.all.order('created_at DESC')
	end

	def create_song
		@song = Song.create(title:params[:title], artist:params[:artist],count_song: 1)
		if @song.invalid?
			flash[:error] = @song.errors.full_messages
			redirect_to '/songs'
		else
			Fav.create(user:User.find(session[:user_id]), song: Song.last, count_fav: 1)
			redirect_to '/songs'
		end
	end

	def add_song
		Song.find(params[:id]).increment!(:count_song)
		y = Fav.where(user:User.find(session[:user_id]),song:Song.find(params[:id]))
		if y.empty? == false
			x = Fav.where(user:User.find(session[:user_id]),song:Song.find(params[:id])).first.id
			Fav.find(x).increment!(:count_fav)
		else
			Fav.create(user:User.find(session[:user_id]), song: Song.find(params[:id]), count_fav:1)
		end
		redirect_to '/songs'
	end

	def show_users
		@songg = Song.find(params[:id])
		@userfavs = Fav.select('*').joins(:song).joins(:user).where(song_id:params[:id])
	end

	def show_playlist
		@user = User.find(params[:id])
		@fav = Fav.select('*').joins(:song).joins(:user).where(user_id:params[:id])
	end

	def delete_session
		# session.clear
		session[:user_id] = nil
		redirect_to '/main'
	end

end
