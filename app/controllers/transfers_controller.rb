class TransfersController < ApplicationController
  def index
    @accounts = Account.all
    @accountselected = Account.first
  end

  def onaccountselection
    @accountselected = params[:transfer][:account]
  end

  def transfer_params
    params.require(:transfer).permit(:account, :type)
  end

end
