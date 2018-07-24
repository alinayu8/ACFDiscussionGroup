module Contexts
    module DiscussionGroups
      # Context for items (assumes no prior contexts)
  
      def create_dgs
        @alinadg = FactoryBot.create(:discussionGroup, largeGroup: @lg1)
        @valeriedg = FactoryBot.create(:discussionGroup, name: "Valerie Wan", gender: "female", largeGroup: @lg1)
        @abbeydg = FactoryBot.create(:discussionGroup, name: "Abbey Ott", gender: "female", largeGroup: @lg1)
        @nowadg = FactoryBot.create(:discussionGroup, name: "Nowa Bronner", gender: "male", largeGroup: @lg1)
        @andrewdg = FactoryBot.create(:discussionGroup, name: "Andrew Kwon", gender: "male", largeGroup: @lg1)
        @charliedg = FactoryBot.create(:discussionGroup, name: "Charlie Ma", gender: "male", largeGroup: @lg1)
      end
  
      def destroy_dgs
        @alinadg.delete
        @valeriedg.delete
        @abbeydg.delete
        @nowadg.delete
        @andrewdg.delete
        @charliedg.delete
      end
  
    end
end