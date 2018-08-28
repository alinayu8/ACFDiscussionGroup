class MembersController < ApplicationController
	before_action :set_member, only: [:show, :edit, :update, :destroy]
	def index
		@member = Member.all.alphabetical
	end

	def edit
		respond_to do |format|
			format.html
			format.js
		end
	end

	def new
		@member = Member.new
		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
		@member = Member.find(params[:id])
	end

	def create
		@member = Member.new(member_params)
		if @member.save
			redirect_to @member_index, notice: "Successfully added #{@member.name} as a member."
		else
			flash[:error] = "Error in creating member"
			redirect_to @member_index
		end
	end

	def update
		if @member.update_attributes(member_params)
			flash[:notice] = "Successfully updated #{@member.name}."
			redirect_to @member_index
		else
			flash[:error] = "Error in editing #{@member.name}"
			redirect_to @member_index
		end
	end

	def destroy 
		if @member.destroy
			redirect_to cell_groups_url, notice: "Successfully removed Cell Group #{@member.name}."
		else
			flash[:error] = "Error in deleting #{@member.name}"
			redirect_to @member_index
		end
	end

	private
	def set_member
		@member = Member.find(params[:id])
	end

	def member_params
		params.require(:member).permit(:name, :gender, :year)
	end
end