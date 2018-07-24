# require needed files
require './test/sets/cellGroups'
require './test/sets/discussionGroups'
require './test/sets/largeGroups'
require './test/sets/memberDgs'
require './test/sets/members'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::CellGroups
  include Contexts::DiscussionGroups
  include Contexts::LargeGroups
  include Contexts::MemberDgs
  include Contexts::Members
end