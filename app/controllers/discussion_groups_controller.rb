class DiscussionGroupsController < ApplicationController
	before_action :set_discussion_group, only: [:show, :edit, :update, :destroy]
	#authorize_resource
	private
		def set_discussion_group
			@discussion_group = DiscussionGroup.find(params[:id])
		end

		def discussion_group_params
			params.require(:discussion_group).permit(:name)
		end
end