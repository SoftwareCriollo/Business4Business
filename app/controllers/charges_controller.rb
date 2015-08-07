class ChargesController < ApplicationController

  def new
  end

  def create
    @amount = 5000
    customer = Stripe::Customer.create(
      :email => current_company.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Pay Plan One Year b4b',
      :currency    => 'usd'
    )

    respond_to do |format|
      save_payment
      format.json { render json: { message: charge.status } }
    end

    rescue Stripe::CardError => e
      @message = e.message
      respond_to do |format|
        format.json { render json: { message: @message } }
      end
  end

  def save_payment
    payment = current_company.payments.new(amount:@amount)
    payment.save
  end

end
