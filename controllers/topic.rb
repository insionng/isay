#encoding:utf-8
require "time"
require "./helpers/pwhash"
require "./helpers/sort"

module ISay
	class App < Sinatra::Base


		dataset = Sequel::Model.db.from(:topics)
		usr = Sequel::Model.db.from(:users)

		#处理帖子GET
		get '/topic/post' do
			erb :'topic/post', :locals=>{
		  		:dataset_all=>dataset.select(:id, :title).order(:title).filter{id < 100}.all,
		  	}
		end

		#处理帖子POST
		post '/topic/post' do
			posttitle=params[:posttitle]
			postcontent=params[:postcontent]
			require "time"
			itime=Time.new(2012, 11, 27)
			hotness=Sort.hot(itime,0,0)
			views=1
			dataset.insert(:title => posttitle, :topic => postcontent,:by_username=>'Insion',:by_email=>'insion@lihuashu.com',:views=>views,:hotness=>hotness,:created_at=>Time.now,:updated_at=>Time.now)

			redirect '/'
		end

		#显示帖子内容
		get '/topic/:id' do
			sid=params[:id]

			erb :'topic/topic', :locals=>{
		  		:topic=>dataset.where(:id=>sid).first
		  	}
		end

	end
end