class PirateController < ApplicationController
  def new
    @pirate = Pirate.new
  end
  def show
    @pirate = Pirate.first
  end


  def create
    @pirate = Pirate.new(pirate_params)    # Not the final implementation!
    if @pirate.save
      redirect_to @pirate
    else
      render '/index'
    end
  end
  def pirate_params
    params.require(:pirate).permit(:name)
  end
end
