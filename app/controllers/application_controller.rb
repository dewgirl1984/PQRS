class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def check_client
    @user_agent = request.user_agent
    puts "I GOT THIS FROM USER AGENT"
    puts @user_agent
    #ADDED STATUS NO CONTENT TO SEE IF IT HALTS OUT    
    render :file=>"public/download", :format=>[:html], :status=>"redirected"  if !@user_agent.include? "gtm-oauth2 FIU.fiu/1.0" 
  end

  def authenticate
     puts 'IN AUTHENTICATE'
     @client = OAuth2::Client.new('1074911058218.apps.googleusercontent.com', 'h_F3c5y8DXnNRgpfpnwkixbC', :site=>'https://accounts.google.com')
     
    begin
      @token = OAuth2::AccessToken.from_hash(@client, 
               :access_token=> params[:token])
      response = @token.get('https://www.googleapis.com/oauth2/v1/userinfo')
      data = response.parsed
      puts data
      @current_user = User.find_by_google_id(data['id'])
      @current_user.valid? 
    rescue
      puts 'GOOGLE VALIDATION FAILED!!!'
      #
      render :file=>"public/401",:format=>[:html], :status=>:unauthorized
    end
  end
end
