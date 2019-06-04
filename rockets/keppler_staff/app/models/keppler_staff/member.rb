# frozen_string_literal: true

module KepplerStaff
  # Member Model
  class Member < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    mount_uploader :picture, AttachmentUploader
    acts_as_list
    acts_as_paranoid

    validates_presence_of :name, :email, :member_code, :type
    validates_uniqueness_of :member_code, :alias, :email

    def self.index_attributes
      %i[picture name alias email member_code type]
    end

    def avatar
      picture.present? ? picture.url : '/assets/app/default_avatar'
    end

    def member_type
      type&.split('::')&.last&.downcase || ''
    end

    def is_a?(type)
      member_type.eql?(type)
    end

  end
end
