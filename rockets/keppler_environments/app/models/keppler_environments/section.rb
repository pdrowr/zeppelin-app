# frozen_string_literal: true

module KepplerEnvironments
  # Section Model
  class Section < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    mount_uploader :cover, AttachmentUploader
    acts_as_list
    acts_as_paranoid

    validates_presence_of :name
    validates_uniqueness_of :name

    def self.index_attributes
      %i[name]
    end
  end
end
