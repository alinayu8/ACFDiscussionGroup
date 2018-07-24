module Contexts
    module Members
      # Context for items (assumes no prior contexts)
  
      def create_members
        @alina = FactoryBot.create(:member, cellGroup: @kindle)
        @valerie = FactoryBot.create(:member, name: "Valerie Wan", gender: "female", cellGroup: @encounter, is_leader: true)
        @abbey = FactoryBot.create(:member, name: "Abbey Ott", gender: "female", cellGroup: @haven, is_leader: true)
        @nowa = FactoryBot.create(:member, name: "Nowa Bronner", gender: "male", cellGroup: @axial, is_leader: true)
        @andrew = FactoryBot.create(:member, name: "Andrew Kwon", gender: "male", cellGroup: @delta, is_leader: true)
        @charlie = FactoryBot.create(:member, name: "Charlie Ma", gender: "male", cellGroup: @beacon, is_leader: true)
    
        @shanice = FactoryBot.create(:member, name: "Shanice Lam", gender: "female", cellGroup: "Kindle", is_leader: false)
        @stuart = FactoryBot.create(:member, name: "Stuart K", cellGroup: "Beacon", is_leader: false)
        @alex = FactoryBot.create(:member, name: "Alex", gender: "male", is_leader: false)
        @casey = FactoryBot.create(:member, name: "Casey Li", gender: "female")
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