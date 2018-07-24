module Contexts
    module MemberDgs
      # Context for items (assumes no prior contexts)
  
      def create_mdgs
        @alinamdg = FactoryBot.create(:memberDg, member: @alina, discussionGroup: @alinadg)
        @valeriemdg = FactoryBot.create(:memberDg, member: @valerie, discussionGroup: @valeriedg)
        @abbeymdg = FactoryBot.create(:memberDg, member: @abbey, discussionGroup: @abbeydg)
        @nowamdg = FactoryBot.create(:memberDg, member: @nowa, discussionGroup: @nowadg)
        @andrewmdg = FactoryBot.create(:memberDg, member: @andrew, discussionGroup: @andrewdg)
        @charliemdg = FactoryBot.create(:memberDg, member: @charlie, discussionGroup: @charliedg)
    
        @shanicemdg = FactoryBot.create(:memberDg, member: @shanice, discussionGroup: @alinadg)
        @stuartmdg = FactoryBot.create(:memberDg, member: @stuart, discussionGroup: @charliedg, attended: false)
        @alexmdg = FactoryBot.create(:memberDg, member: @alex, discussionGroup: @andrewdg)
        @caseymdg = FactoryBot.create(:memberDg, member: @casey, discussionGroup: @valeriedg, attended: false)
      end
  
      def destroy_mdgs
        @alinamdg.delete
        @valeriemdg.delete
        @abbeymdg.delete
        @nowamdg.delete
        @andrewmdg.delete
        @charliemdg.delete
        @shanicemdg.delete
        @stuartmdg.delete
        @alexmdg.delete
        @caseymdg.delete
      end
  
    end
  end