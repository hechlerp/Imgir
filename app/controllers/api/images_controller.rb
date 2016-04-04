class Api::ImagesController < ApplicationController
	# before_action :require_logged_in

	def index
		@images = Image.all
		render :index
	end

	def new
		@image = Image.new
		render :new
	end

	def show
		@image = Image.find(params[:id])
		render :show
	end

	def create
		@image = Image.new(image_params)
		@image.user_id = current_user.id
		if @image.save
			render :show
		else
			raise "That's not an image, you dingus."
		end
	end

	def update
		@image = Image.find(params[:id])
		if @image.update_attributes(image_params)
			render :show
		else
			raise "Image did not update"
		end
	end

	def edit
	end

	def destroy
	end

	private

	def image_params
		params.require(:image).permit(:title, :description, :private, :img)
	end
end
