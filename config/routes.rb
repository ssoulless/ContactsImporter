# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contacts
  get 'import-contacts', to: 'contacts#import_contacts', as: 'import_contacts'

  is_ajax_request = ->(request) { request.xhr? }
  post 'pre-parse-contacts', to: 'contacts#pre_parse_contacts', constraint: is_ajax_request,
                             as: 'pre_parse_contacts'

  root 'contacts#import_contacts'
end
