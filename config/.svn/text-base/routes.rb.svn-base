ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'show',
	   :action => 'list',
 	   :type => 'upcoming'


  map.show 'show/detail/:id',
	   :controller => 'show',
	   :action => 'detail' 

  map.connect '/show', 
  	   :controller => 'show',
	   :action => 'list',
	   :type => 'upcoming'
			
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
