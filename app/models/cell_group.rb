class CellGroup < ApplicationRecord
    has_many :members

    # Validations
    validates_presence_of :name, :gender
    validates_inclusion_of :gender, in: %w( male female ), message: "is not recognized in the system"

    # Scopes
    scope :for_gender, ->(gender) { where(gender: gender) }
end
