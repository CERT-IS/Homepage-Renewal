module API
	module V1
		class BoardNoticeController < BoardsController

			def index
				super
				@page   	= params[:page].to_i == 0 ? 1 : params[:page].to_i
				@type   	= BoardType.where(name: "notices").first
				@boards  	= @type.boards
				@page_max	= (@boards.count-1) / 6 + 1 if @boards.present?
				@boards 	= @boards.paginate(:page => params[:page], :per_page => 6)
			end

			def show
				super
			end
		end
	end
end