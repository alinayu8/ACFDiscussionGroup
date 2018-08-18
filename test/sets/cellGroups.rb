module Contexts
    module CellGroups
      # Context for items (assumes no prior contexts)
  
      def create_cgs
        @kindle = FactoryBot.create(:cellGroup)
        @encounter = FactoryBot.create(:cellGroup, name: "Encounter", gender: "Female")
        @haven = FactoryBot.create(:cellGroup, name: "Haven", gender: "Female")
        @axial = FactoryBot.create(:cellGroup, name: "Axial", gender: "Male")
        @delta = FactoryBot.create(:cellGroup, name: "Delta", gender: "Male")
        @beacon = FactoryBot.create(:cellGroup, name: "Beacon", gender: "Male")
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