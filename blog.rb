require 'bundler'
Bundler.require

DataMapper.setup(
	:default,
	'mysql://root@localhost/blog'
	)

class Blog
		include DataMapper::Resource
		property :id, Serial
		property :title, String
		property :content, Text
end

DataMapper.finalize.auto_upgrade!

get '/' do
	@blogs = Blog.all
	erb :index
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
