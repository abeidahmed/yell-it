class Authentication
  def initialize(params)
    @email_address = params[:email_address].downcase
    @password      = params[:password]
  end

  def authenticated?
    !!user
  end

  def user
    fetch_user
  end

  private

  attr_reader :email_address, :password

  def fetch_user
    @user ||= User.find_by(email_address: email_address)
    return unless @user

    @user.authenticate(password) ? @user : nil
  end
end
