require 'test_helper'

class MemberTest < ActiveSupport::TestCase
    context "Creating context" do
        setup do
            create_cgs
            create_members
        end
        
        teardown do
            destroy_cgs
            destroy_members
        end

        should "add one year to members" do
            Member.add_one_year
            assert_equal Member.all.map(&:year).last(3), [4, 2, 3]
        end
      
        should "parse through text of names" do
            text = """
            Christian, 2, Beacon, Male
            Hanna, 3, Kindle
            Nick, 1, male
            
            """
            Member.member_list(text)
            assert_equal Member.all.map(&:name).last(3), ["Christian", "Hanna", "Nick"]

            bad_text = """
            James, Axial, male, 1
            Jason
            """
            Member.member_list(bad_text)
            assert_equal Member.all.count, 13

            worse_text = """
            Annabelle
            Bloop, Bloop, Bloop
            Beep, Beep, Beep, Beep
            John, Boop, male
            """
            Member.member_list(worse_text)
            assert_equal Member.all.count, 13
        end
    end
end
