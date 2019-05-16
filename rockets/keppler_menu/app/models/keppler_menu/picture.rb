module KepplerMenu
  class Picture < ApplicationRecord
    mount_uploader :picture, AttachmentUploader
    belongs_to :picturable, polymorphic: true
  end
end
