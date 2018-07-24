module Contexts
    module CellGroups
      # Context for items (assumes no prior contexts)
  
      def create_cgs
        @kindle = FactoryBot.create(:cellGroup)
        @encounter = FactoryBot.create(:cellGroup, name: "Encounter", gender: "female")
        @haven = FactoryBot.create(:cellGroup, name: "Haven", gender: "female")
        @axial = FactoryBot.create(:cellGroup, name: "Axial", gender: "male")
        @delta = FactoryBot.create(:cellGroup, name: "Delta", gender: "male")
        @beacon = FactoryBot.create(:cellGroup, name: "Beacon", gender: "male")
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