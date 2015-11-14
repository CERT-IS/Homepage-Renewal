class BoardsController < ApplicationController
	before_action :authenticate
	
	def index
	end

	def show
	end

	def new
	end

	def create
		@board 		 = current_user.boards.new
		@board.title = params[:board][:title]

		doc = Nokogiri::HTML(params[:board][:contents])
		doc.css("img").each do |f|
			unless uri?(f["src"])
				attachment = @board.attachments.build
				attachment.contents 			 = Paperclip.io_adapters.for(f["src"])
				attachment.contents_file_name    = f["data-filename"]
				if attachment.save
					# p attachment.contents.url
					new_node = doc.create_element "img", src: attachment.contents.url
					f.replace new_node
				end
			end
		end

		@board.contents =  doc.xpath('//body').inner_html
		@board.save
	end

	def destory
	end
end
