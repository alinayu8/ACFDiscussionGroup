module Contexts
    module LargeGroups
      # Context for items (assumes no prior contexts)
  
      def create_lgs
        @lg1 = FactoryBot.create(:largeGroup)
        @lg2 = FactoryBot.create(:largeGroup, date: Date.current - 7, semester: "f18", session_number: "2")
        @lg3 = FactoryBot.create(:largeGroup, date: Date.current - 14, semester: "f18", session_number: "3")
      end
  
      def destroy_lgs
        @lg1.delete
        @lg2.delete
        @lg3.delete
      end
  
    end
end