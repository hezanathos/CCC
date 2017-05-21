module PirateHelper
  # Returns the Gravatar for the given pirate.
  def gravatar_for(pirate,widthVar,heightVar)
    gravatar_id = Digest::MD5::hexdigest(pirate.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: pirate.email, class: "gravatar",height:heightVar,width:widthVar)
  end
end


