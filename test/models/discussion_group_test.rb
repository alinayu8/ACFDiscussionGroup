require 'test_helper'

class DiscussionGroupTest < ActiveSupport::TestCase
  context "Creating context" do
        setup do 
            create_cgs
            create_lgs
        end
        
        teardown do
            destroy_cgs
            destroy_lgs
        end
    
        should "initialize discission groups" do
            DiscussionGroup.initialize_dgs(@lg1)
            assert_equal DiscussionGroup.all.count, 6
        end
    end
end
