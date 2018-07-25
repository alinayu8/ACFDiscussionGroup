require 'test_helper'

class MemberTest < ActiveSupport::TestCase
    context "Creating context" do
        setup do
            create_cgs
        end
        
        teardown do
            destroy_cgs
        end
      
        should "parse through text of names" do
            text = """
            Christian, Beacon, male
            Hanna, Kindle
            Nick, male
            
            """
            Member.member_list(text)
            assert_equal Member.all.map(&:name), ["Christian", "Hanna", "Nick"]

            bad_text = """
            James, Axial, male
            Jason
            """
            Member.member_list(bad_text)
            assert_equal Member.all.count, 3

            worse_text = """
            Annabelle
            Bloop, Bloop, Bloop
            Beep, Beep, Beep, Beep
            John, Boop, male
            """
            Member.member_list(worse_text)
            assert_equal Member.all.count, 3
        end
    end
end
