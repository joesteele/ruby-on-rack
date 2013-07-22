require 'rack'
run Proc.new {[200, {}, ['Hello World from Rack Demo!']]}
