class PasswordsController < Devise::PasswordsController
  layout 'public', only: [:new, :edit]
end