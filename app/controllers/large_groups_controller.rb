class LargeGroupsController < ApplicationController
	before_action :set_large_group, only: [:show, :edit, :update, :destroy, :shuffle, :reset, :add_or_reassign]
	def index
		@large_group = LargeGroup.all
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
		@discussion_groups = DiscussionGroup.all.where(largeGroup: @large_group).alphabetical
	end 


	def update
		@large_group = LargeGroup.find(params[:id])
		if @large_group.update(large_group_params)
			redirect_to @large_group  
		else 
			render 'edit'
		end 
	end 

	def edit
		@large_group = LargeGroup.find(params[:id])
	end

	def shuffle
		DiscussionGroup.randomize(@large_group)
		flash[:notice] = "Discussion groups randomized!"
    	redirect_to large_group_path(@large_group)
	end
	
	def reset
		DiscussionGroup.reset(@large_group)
		flash[:notice] = "Discussion groups reset!"
    	redirect_to large_group_path(@large_group)
	end
	
	def add_or_reassign
		@dg = DiscussionGroup.find(params[:id])
		@member = Member.new
		@memberDg = MemberDg.new
		@cell_groups = CellGroup.alphabetical.all
		@members = Member.alphabetical.all
		@dgs = DiscussionGroup.where(largeGroup: @dg.largeGroup)
		respond_to do |format|
			format.html
			format.js
		end
	end

	private 
	def set_large_group
		@large_group = LargeGroup.find(params[:id])
	end

	def large_group_params
		params.require(:large_group).permit(:date, :session_number, :semester)
	end 

end