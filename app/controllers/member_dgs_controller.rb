class MemberDgsController < ApplicationController
	#before_action :set_member_dgs, only: [:show, :edit, :update, :destroy]
    #authorize_resource
    
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
			params.require(:member_dg).permit(:attended)
		end
end



