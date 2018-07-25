require 'test_helper'

class MemberTest < ActiveSupport::TestCase
    context "Creating context" do
        setup do 
            create_cellGroups
            create_members
        end
        
        teardown do
            destroy_cellGroups
            destroy_members
        end
      
        should "parse through text of names" do
            text = """
            Christian, Beacon, male
            Hanna, Kindle
            Nick, male
            
            """
            Member.member_list(text)
            assert equal Member.all.count, 13

            bad_text = """
            James, Axial, male
            Jason
            """
            Member.member_list(bad_text)
            assert equal Member.all.count, 14

            worse_text = """
            Annabelle
            Bloop, Bloop, Bloop
            Beep, Beep, Beep, Beep
            John, Boop, male
            """
            Member.member_list(worse_text)
            assert equal Member.all.count, 14
        end
    end
end
