Router.configure do
  map '/',                     controller: 'root',     action: 'index'
  map '/user',                 controller: 'profile',  action: 'show'
  map '/sign-in',              controller: 'sessions', action: 'new'
  map '/sign-out',             controller: 'sessions', action: 'destroy'
  map '/auth/github/callback', controller: 'sessions', action: 'create'
end
