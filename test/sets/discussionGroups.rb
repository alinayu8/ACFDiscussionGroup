module Contexts
    module DiscussionGroups
      # Context for items (assumes no prior contexts)
  
      def create_dgs
        @kindle = FactoryBot.create(:CellGroup)
        @encounter = FactoryBot.create(:CellGroup, name: "Encounter", gender: "female")
        @haven = FactoryBot.create(:CellGroup, name: "Haven", gender: "female")
        @axial = FactoryBot.create(:CellGroup, name: "Axial", gender: "male")
        @delta = FactoryBot.create(:CellGroup, name: "Delta", gender: "male")
        @beacon = FactoryBot.create(:CellGroup, name: "Beacon", gender: "male")
      end
  
      def destroy_cgs
        @kindle.delete
        @encounter.delete
        @haven.delete
        @axial.delete
        @delta.delete
        @beacon.delete
      end
  
    end
  end