require 'test_helper'

class DiscussionGroupTest < ActiveSupport::TestCase
  context "Creating context" do
        setup do 
            create_cgs
            create_lgs
            create_members
        end
        
        teardown do
            destroy_cgs
            destroy_lgs
            destroy_members
        end
    
        should "initialize discission groups" do
            DiscussionGroup.initialize_dgs(@lg1)
            assert_equal MemberDg.count, 10
        end
        
        # This test will always fail because it will be a different order every time, so don't bother. Good for experimenting.
        should "shuffle discussion groups" do   
            DiscussionGroup.initialize_dgs(@lg1)
            DiscussionGroup.randomize(@lg1) # test randomize once
            DiscussionGroup.randomize(@lg1) # test if press randomize again
            assert_equal MemberDg.all, []
            
        end
    end
end
