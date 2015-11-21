class BoardsController < ApplicationController
	before_action :authenticate_user!
	
	def index
	end

	def show
		@board = Board.where(id: params[:id]).first

		# 부정접근 처리
		unless @board.present?
			redirect_to root_path
		end

		@comments = @board.comments.where(comment_id: nil)
	end

	def new
	end

	def create
		@board 		 = current_user.boards.new
		@board.title = params[:board][:title]

		doc = Nokogiri::HTML(params[:board][:contents])
		doc.css("img").each do |f|
			# 직접 업로드한 경우
			unless uri?(f["src"])
				attachment = @board.attachments.build
				attachment.contents 			 = Paperclip.io_adapters.for(f["src"])
				attachment.contents_file_name    = f["data-filename"]

				if attachment.save
					# 이미지 반응형
					style 	  = f["style"]
					width 	  = style[/width:.*px;/]
					if width.present?
						style = style.gsub(width, "max-" + width)
						style << "width:100%;"
					end

					height = style[/height:.*px;/]
					if height.present?
						style = style.gsub(height, "max-" + height)
						style << "height:100%;"
					end

					tag = "<a href='#{attachment.contents.url}' data-lightbox='example-set' data-title='#{attachment.contents_file_name}'>
					<img src='#{attachment.contents.url}' class='#{f["class"]}' style='#{style}'></a>"

					# new_node = doc.create_element "img", src: attachment.contents.url, class: f["class"], style: style
					f.replace tag
				end
			# 외부 이미지 참조인 경우
			else
				new_node = doc.create_element "img", src: f["src"], class: f["class"], style: f["style"] + "width:100%;"
				f.replace new_node
			end
		end

		@board.contents =  doc.xpath('//body').inner_html
		@board.save
	end

	def destory
	end
end
