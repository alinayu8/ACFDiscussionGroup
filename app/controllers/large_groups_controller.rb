class LargeGroupsController < ApplicationController

	def index
		@large_group = LargeGroup.all.by_created
	end 

	def new
		@large_group = LargeGroup.new 
	end 

	def create
		@large_group = LargeGroup.new(large_group_params)

		if @large_group.save 
			redirect_to @large_group_index
		else
			render 'new'
		end 
	end 

	def show
		@large_group = LargeGroup.find(params[:id])
	end 


	def update
		@large_group = LargeGroup.find(params[:id])

		if @large_group.update(note_params)
			redirect_to @large_group  
		else 
			render 'edit'
		end 
	end 


	def edit
		@large_group = LargeGroup.find(params[:id])
	end 


	private 

	def large_group_params
		params.require(:large_group).permit(:date, :session_number, :semester)
	end 

end