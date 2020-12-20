class SignUpConfirmationRequests::Create < BrowserAction
  include Auth::RedirectSignedInUsers

  route do
    RequestSignUpConfirmation.run(params) do |_operation, user|
      if user
        if user.confirmed?
          SignUpAlreadyConfirmedEmail.new(user).deliver_later
        else
          SignUpConfirmationEmail.new(user).deliver_later
        end
      end

      flash.keep
      flash.success = "If your email is in our system, you will receive an email shortly"
      redirect to: SignIns::New
    end
  end
end
