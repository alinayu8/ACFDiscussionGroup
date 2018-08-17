module Contexts
    module Members
      # Context for items (assumes no prior contexts)
  
      def create_members
        @alina = FactoryBot.create(:member, cellGroup: @kindle)
        @valerie = FactoryBot.create(:member, name: "Valerie Wan", gender: "female", cellGroup: @encounter, is_leader: true, year: 4)
        @abbey = FactoryBot.create(:member, name: "Abbey Ott", gender: "female", cellGroup: @haven, is_leader: true, year: 4)
        @nowa = FactoryBot.create(:member, name: "Nowa Bronner", gender: "male", cellGroup: @axial, is_leader: true, year: 4)
        @andrew = FactoryBot.create(:member, name: "Andrew Kwon", gender: "male", cellGroup: @delta, is_leader: true, year: 4)
        @charlie = FactoryBot.create(:member, name: "Charlie Ma", gender: "male", cellGroup: @beacon, is_leader: true, year: 4)
    
        @shanice = FactoryBot.create(:member, name: "Shanice Lam", gender: "female", cellGroup: @kindle, is_leader: false, year: 2)
        @stuart = FactoryBot.create(:member, name: "Stuart K", gender: "male", cellGroup: @beacon, is_leader: false, year: 3)
        @alex = FactoryBot.create(:member, name: "Alex", gender: "male", is_leader: false, cellGroup: nil, year: 1)
        @casey = FactoryBot.create(:member, name: "Casey Li", gender: "female", is_leader: false, cellGroup: nil, year: 2)
      end
  
      def destroy_members
        @alina.delete
        @valerie.delete
        @abbey.delete
        @nowa.delete
        @andrew.delete
        @charlie.delete
        @shanice.delete
        @stuart.delete
        @alex.delete
        @casey.delete
      end
  
    end
  end