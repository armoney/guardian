Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  resources :users

  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

  resources :events

  get '/sms/text_friend' => 'sms#text_friend'
  get '/sms/text_friend_once_home' => 'sms#text_friend_once_home'

end
