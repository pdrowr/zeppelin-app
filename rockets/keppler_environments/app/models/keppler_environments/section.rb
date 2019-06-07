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

    # has_many :tables, foreign_key: 'id_consumo', class_name: 'KepplerEnvironments::Table'

    acts_as_list
    acts_as_paranoid

    validates_presence_of :name
    validates_uniqueness_of :name

    def self.index_attributes
      %i[name]
    end

    def tables
      begin
        Table.where(id_consumo: table_ids)
      rescue Exception => e
        print e
      end

    end

  end
end
