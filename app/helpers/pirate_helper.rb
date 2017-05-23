# frozen_string_literal: true

# pirate helper
#
# @author Alex Lecoq
# @since 0.0.0
module PirateHelper
  # Returns the Gravatar for the given pirate.
  def gravatar_for(pirate, width_var, height_var)
    gravatar_id = Digest::MD5.hexdigest(pirate.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: pirate.email, class: 'gravatar',
                            height: height_var, width: width_var)
  end
end
