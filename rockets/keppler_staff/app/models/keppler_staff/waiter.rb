# frozen_string_literal: true

module KepplerStaff
  # Waiter Model
  class Waiter < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    mount_uploader :avatar, AttachmentUploader
    acts_as_list
    acts_as_paranoid

    validates_presence_of :name, :waiter_code
    validates_uniqueness_of :email, :waiter_code

    def waiter_avatar
      avatar.present? ? avatar.url : '/assets/app/default_avatar'
    end

    def self.index_attributes
      %i[avatar name username email waiter_code]
    end
  end
end
