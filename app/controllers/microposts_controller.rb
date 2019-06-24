class MicropostsController < ApplicationController


  def index
		@micropost = Micropost.paginate(page: params[:page])
	end 

	def new
		@micropost = current_user.microposts.build
	end

	def create
	    @micropost = current_user.microposts.build(micropost_params)
	    if @micropost.save
	      flash[:success] = "Micropost created!"
	      redirect_to microposts_path
	    else
	      render 'static_pages/home'
	    end
  	end

  	private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    
end
