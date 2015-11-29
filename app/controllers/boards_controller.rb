class BoardsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_board, only: [:show, :edit, :update, :destroy]
	before_action :check_auth, only: [:edit, :update, :destroy]
	
	def index
	end

	def show
		# 부정접근 처리
		unless @board.present?
			redirect_to root_path
			return
		end

		@comments = @board.comments.where(comment_id: nil)
	end

	def new
	end

	def create
		@board 		 	= current_user.boards.new
		@board.title 	= params[:board][:title]

		doc				= image_parsing
		@board.contents = doc.xpath('//body').inner_html
		@board.save
	end

	def edit
		@board_type = @board.board_type
	end

	def update
		@board.title 	= params[:board][:title]
		doc 		 	= image_parsing
		@board.contents = doc.xpath('//body').inner_html
		@board.save

		redirect_to "/#{@board.board_type.name}/#{@board.id}"
	end

	def destroy
		redirect_to "/#{@board.board_type.name}"
		@board.destroy
	end




	private

	def get_board
		@board = Board.where(id: params[:id]).first
	end

	def check_auth
		authorize_action_for @board
	end

	def image_parsing
		doc = Nokogiri::HTML(params[:board][:contents])
		doc.css("img").each do |f|
			
			p f["src"]
			if f["src"].start_with?("/attaches")
				# 이미 서버에 저장된 이미지인 경우
			elsif uri?(f["src"])
				# 외부 이미지 참조인 경우
				style = f["style"]
				style += "width:100%;" if style.present?
				new_node = doc.create_element "img", src: f["src"], class: f["class"], style: f["style"] + "width:100%;"
				f.replace new_node
			else
				# 직접 업로드한 경우
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
			end
		end

		doc
	end
end
