require 'sinatra'

set :port, 80
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    erb :index
end

get '/customize' || '/customize/' do
    erb :customize
end

post '/customize/' do
    custom_dir = Dir.home + "/website/submissions/" + Time.now.to_i.to_s
    Dir.mkdir(custom_dir)
    File.open("#{custom_dir}/dimensions.txt", "w"){|f| f.write("Sides: #{params[:sides]}\nSize: #{params[:size]}")}
    params[:sides].to_i.times do |i|
        File.open(custom_dir + "/" + params["image_#{i}".to_sym][:filename], "w") do |f|
            f.write(params["image_#{i}".to_sym][:tempfile].read)
        end
    end

    erb :success
end

get '/about' || '/about/' do
    erb :about
end

get '/success' || '/success/' do
    erb :success
end
