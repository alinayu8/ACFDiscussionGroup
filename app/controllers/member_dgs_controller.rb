class MemberDgsController < ApplicationController
	before_action :set_member_dgs, only: [:new]
    #authorize_resource

    def new 
        @mdg = MemberDg.new
    end

    # called when the edit button is clicked on a large group
    def create
        @mdg = MemberDg.new(member_dg_params)
        if @mdg.save
            if !@mdg.member.is_active # reactiving inactive member
                @mdg.member.update_attributes(:is_active => true)
            else # reassignment
                MemberDg.select{|mdg| (@mdg.member == mdg.member) && (@mdg.discussionGroup.largeGroup == mdg.discussionGroup.largeGroup)}.first.delete
            end
            redirect_to large_group_path(@mdg.discussionGroup.largeGroup), notice: "Successfully switched #{@mdg.member.name} to #{@mdg.discussionGroup.name}'s discussion group."
        else
            flash[:error] = "Error in adding Member to Discussion Group"
            redirect_to arge_group_path(@mdg.discussionGroup.largeGroup)
        end
    end

    def update
        @mdg = MemberDg.find(params[:id])
        respond_to do |format|
            if @mdg.update_attributes(member_dg_params)
                  format.json { respond_with_bip(@mdg) }
            else
                  format.json { respond_with_bip(@mdg) }
            end
          end
    end

	private
		def set_member_dgs
			@member_dg = MemberDg.find(params[:id])
		end

		def member_dg_params
			params.require(:member_dg).permit(:attended, :discussionGroup_id, :member_id)
		end
end