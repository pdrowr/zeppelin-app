# frozen_string_literal: true

module KepplerClients
  # Client Model
  class Client < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    acts_as_list
    acts_as_paranoid

    def self.index_attributes
      %i[name identification email address code]
    end
  end
end
