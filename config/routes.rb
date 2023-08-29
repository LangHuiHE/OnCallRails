Rails.application.routes.draw do
  resources :user_teams
  resources :user_settings
  resources :users
  resources :twilio_retries
  resources :twilio_delivery_statuses
  resources :template_variables
  resources :template_contents
  resources :template_actives
  resources :templates
  resources :teams
  resources :target_types
  resources :target_roles
  resources :target_reprioritizations
  resources :target_modes
  resources :target_contacts
  resources :target_application_modes
  resources :targets
  resources :responses
  resources :priorities
  resources :plan_notifications
  resources :plan_actives
  resources :plans
  resources :oncall_teams
  resources :notification_categories
  resources :mode_template_overrides
  resources :modes
  resources :message_changelogs
  resources :messages
  resources :mailing_list_memberships
  resources :mailing_lists
  resources :incident_emails
  resources :incidents
  resources :global_stats
  resources :generic_message_sent_statuses
  resources :dynamic_plan_maps
  resources :devices
  resources :default_application_modes
  resources :comments
  resources :category_overrides
  resources :application_stats
  resources :application_quota
  resources :application_owners
  resources :application_modes
  resources :application_custom_sender_addresses
  resources :applications
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
