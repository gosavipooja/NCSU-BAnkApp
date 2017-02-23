class BeneficiariesController < ApplicationController
  def index
    @beneficiaries = Beneficiary.all
    #@beneficiaries = Beneficiary.find_by_sql(["select * from beneficiaries where email = :uid order by time_start desc", {:uid => params[:id]}])
  end

  def show
    redirect_to :action => 'index'
  end

  def add
    render 'add'
  end

  def create
    valid = Account.match(params[:beneficiary][:beneficiaryemail], params[:beneficiary][:account])
    if valid
      @beneficiary = Beneficiary.new(beneficiary_params)
      if @beneficiary.save
        redirect_to :action => 'index'
        puts "Save Successful"
      else
        flash[:notice]="Beneficiary already exist / error adding beneficiary"
        render 'add'
      end
    else
      flash[:notice]="Email and account number doesn't match"
      render 'add'
    end
  end

  def destroy
    @beneficiary = Beneficiary.find(params[:id])
    @beneficiary.destroy
    redirect_to :action => 'index'
  end

  private
  def beneficiary_params
    params.require(:beneficiary).permit(:email, :account, :nickname)
  end

end
