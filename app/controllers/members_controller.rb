class MembersController < ApplicationController
	before_action :set_member, only: [:new]
	def index
	end	

	def new
		@member = Member.new
		@member.memberDgs.build
	end

	def edit
		@member.memberDgs.build
	end

	# called when the edit button is clicked on a large group
	def create_members_and_dg
		@dg = DiscussionGroup.find(params[:id])
		@member = Member.new(member_params)
		if @member.save
			MemberDg.create!(discussionGroup: @dg, member: @member, attended: true)
			redirect_to large_group_path(@dg.largeGroup), notice: "Successfully added #{@member.name} to #{@dg.name}'s discussion group."
		else
			flash[:error] = "Error in creating Member"
			redirect_to large_groups_path(@dg.largeGroup)
		end
	end

	private
	def set_member
		@member = Member.find(params[:id])
	end

	def member_params
		params.require(:member).permit(:name, :gender, :is_leader, :is_active, :year, :cellGroup_id)
	end
end