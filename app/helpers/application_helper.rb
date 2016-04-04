module ApplicationHelper
	include HttpResponseCodes

	def process_response response, status, params
		api_response = Hash.new
		if status == 200
			api_response.merge!({status: 'OK', message: 'success'})
		elsif status == 500
			raise response
		else
			handle_logging(response, status, params)
			api_response.merge!( { status: status, message: RESPONSE[status] } )
		end
		api_response['result'] = response
		render json: api_response.to_json.html_safe, status: status
	end

	def handle_logging response, status, params
		action = params["action"]
		log_file.error "#{action} || #{status} || #{response} || #{params.except!("controller","action")}"
	end

	def log_file(file_name='development')
		file_str = File.join "#{Rails.root}","log", "#{file_name}.log"
		File.new(file_str,"w") unless File.exist?(file_str)
		log_file = Logger.new(file_str)
		log_file
	end
end
