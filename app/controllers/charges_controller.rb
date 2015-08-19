class ChargesController < ApplicationController

  def pay
    render layout: "pay"
  end

  def create
    charge = make_charges(create_customer, 60000)

    respond_to do |format|
      save_payment
      format.json { render json: { message: charge.status, url: edit_company_url(current_company) } }
    end

    rescue Stripe::CardError => e
      @message = e.message
      respond_to do |format|
        format.json { render json: { message: @message } }
      end
  end

private

  def save_payment
    payment = current_company.payments.new(amount:@amount)
    payment.save
  end

  def create_customer
    Stripe::Customer.create(
      email: current_company.email,
      card: params[:stripeToken]
    )
  end

  def make_charges(customer, amount)
    Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: 'Pay Plan One Year b4b',
      currency: 'usd'
    )
  end

end
