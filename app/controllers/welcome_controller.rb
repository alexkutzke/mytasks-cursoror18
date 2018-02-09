class WelcomeController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@lists = List.where(user_id: current_user.id)
  end
end
