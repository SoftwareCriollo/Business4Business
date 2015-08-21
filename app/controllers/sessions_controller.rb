class SessionsController < Devise::SessionsController
  layout 'public', only: [:new]
end