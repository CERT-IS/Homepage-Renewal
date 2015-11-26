module API
	module V1
		class BoardNoticeController < BoardsController

			def index
				super
				@page   	= params[:page].to_i == 0 ? 1 : params[:page].to_i
				@type   	= BoardType.where(name: "notices").first
				@boards  	= @type.boards
				@page_max	= (@boards.count-1) / 4 + 1 if @boards.present?
				@boards 	= @boards.paginate(:page => params[:page], :per_page => 4)
				
				respond_to do |format|
					format.html
					format.json { render json: @boards, except: [:contents, :updated_at, :user_id], include: {user:{only: :uid}}, status: 200 } 
				end
			end
		end
	end
end