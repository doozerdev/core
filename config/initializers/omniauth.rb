OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1474823829455959', 'b59ebb250ba214f7fc49f2f970de9989'
end