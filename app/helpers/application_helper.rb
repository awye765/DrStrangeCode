module ApplicationHelper
	def alert_for(flash_type)
		{
			:success => 'success',
			:error => 'error',
			:alert => 'alert',
			:notice => 'notice'
		}[flash_type.to_sym] || flash_type.to_s
	end
end
