Rails.application.routes.draw do

  # navigation
  root 'navigation#homepage'

  scope "/:locale" do
    get 'questions' => 'navigation#questions'

    # for activation
    get 'account_activation/:token/activate', to: 'access#account_activation',
                                              as: 'activation'
    get 'activation_form', to: 'access#activation_form', as: 'activation_form'
    post 'create_activation', to: 'access#create_activation',
                              as: 'create_activation'

    # for password reset
    get 'account_activation/:token/reset', to: 'access#reset_password',
                                              as: 'reset_password'
    get 'reset_password_form', to: 'access#reset_password_form',
                               as: 'reset_password_form'
    post 'create_reset_link', to: 'access#create_reset_link',
                              as: 'create_reset_link'

    # for login
    get 'login_form' => 'access#login_form'
    post 'create_session' => 'access#create_session'
    delete 'destroy_session' => 'access#destroy_session'

    # for sending photos
    get 'photo/:id/:type/get', to: 'photos#send_photo', as: 'get_photo'
	  get 'humans/:id/avatar', to: 'humans#send_avatar', as: 'avatar'

    resources :humans

    resources :photo_galleries, shallow: true do
      resources :photos, except: :show
    end

    resources :photos, only: :show do
      resources :comments, only: [:create]
    end

    resources :comments, only: [:destroy]
	  resources :chats, only: [:show, :index, :create]

  end

end
