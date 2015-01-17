require 'bundler'
Bundler.require

DataMapper.setup(
	:default,
	'mysql://root@localhost/blog'
	)
class User
	include DataMapper::Resource
	property :id, Serial
	property :username, String
	property :password, String
end
class Blog
		include DataMapper::Resource
		property :id, Serial
		property :title, String
		property :content, Text
end

DataMapper.finalize.auto_upgrade!

get '/' do
	@blogs = Blog.all
	@users = User.all
	erb :index
end
get '/login' do
	erb :login
end
post '/create-user' do
	p params
	@user = User.new
	@user.username = params[:username]
	@user.password = params[:password]
	@user.save
	redirect to '/'
end
get '/user/:id' do
	@user = User.get params[:id]
	erb :show_user
end
delete '/delete-user/:id' do
	@user = User.get params[:id]
	@user.destroy
	redirect to '/'
end
get'/edit-user/:id' do
	p params
	@user = User.get params[:id]
	erb :edit_user
end
patch '/save-user/:id' do
	@user = User.get params[:id]
	@user.update password:params[:password]
	redirect to '/'
end
get '/new_blog' do
	erb :create_blog
end

post '/create-blog' do
	p params
	@blog = Blog.new
	@blog.title = params[:title]
	@blog.content = params[:content]
	@blog.save
	redirect to '/'
end
get '/blog/:id' do
	@blog = Blog.get params[:id]
	erb :show_blog
end
delete '/delete-blog/:id' do
	@blog = Blog.get params[:id]
	@blog.destroy
	redirect to '/'
end
get '/edit-blog/:id' do
	@blog = Blog.get params[:id]
	erb :edit_blog
end
patch '/save-blog/:id' do
	@blog = Blog.get params[:id]
	@blog.update content:params[:content]
	redirect to '/'
end
