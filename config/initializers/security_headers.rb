# Configure security headers
Rails.application.config.action_dispatch.default_headers = {
  # Remove X-Frame-Options to allow embedding in iframes
  "X-Frame-Options" => "",
}
