# frozen_string_literal: true

# Small module for identify the dom_id of a model
module RailsDomIdHelper
  def dom_id_for(model)
    ['#', ActionView::RecordIdentifier.dom_id(model)].join
  end
end
