class CellGroupsController < ApplicationController
	before_action :set_cell_group, only: [:show, :edit, :update, :destroy]
	#authorize_resource
	def index
		@cell_groups = CellGroup.all.alphabetical
		@leaders = Member.for_leader
		respond_to do |format|
			format.html
			format.json
		  end
	end

	def edit
		respond_to do |format|
			format.html
			format.js
		end
	end

	def new
		@cell_group = CellGroup.new
		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
	end
	
	def create
		@cell_group = CellGroup.new(cell_group_params)
		if @cell_group.save
			redirect_to cell_groups_path, notice: "Successfully added #{@cell_group.name} as a cell group."
		else
			flash[:error] = "Error in creating Cell Group"
			redirect_to cell_groups_path
		end
	end

	def update
		if @cell_group.update_attributes(cell_group_params)
			flash[:notice] = "Successfully updated #{@cell_group.name}."
			redirect_to @cell_group
		else
			flash[:error] = "Error in editing #{@cell_group.name}"
			redirect_to cell_groups_path
		end
	end

	def destroy 
		if @cell_group.destroy
			redirect_to cell_groups_url, notice: "Successfully removed Cell Group #{@cell_group.name}."
		else
			flash[:error] = "Error in deleting #{@cell_group.name}"
			redirect_to cell_groups_path
		end
	end

	private
		def set_cell_group
			@cell_group = CellGroup.find(params[:id])
		end

		def cell_group_params
			params.require(:cell_group).permit(:name, :gender)
		end
end