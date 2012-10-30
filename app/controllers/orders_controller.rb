class OrdersController < ApplicationController
  
  before_filter :check_for_resource
  before_filter :authenticate_admin!, :only => [:all_orders,:destroy,:send,:to_approve]
  before_filter :authenticate_for_approve!, :only => [:approve]

private

  def customer_or_admin_orders_path
    if admin_signed_in?
      admin_orders_path(@user)
    elsif customer_signed_in?
      customer_orders_path(@user)
    else
      root_path
    end
  end
  
  def check_for_resource
    if admin_signed_in?
      @user = current_admin
    elsif customer_signed_in?
      @user = current_customer
    else
      redirect_to root_path
    end 
  end

  def authenticate_for_approve!
    redirect :to => root_path unless admin_signed_in? || customer_signed_in?
  end

public

 def index
    @orders = @user.orders.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /ordes/1
  # GET /ordes/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /ordes/new
  # GET /ordes/new.json
  def new
    @order = @user.orders.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /ordes/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /ordes
  # POST /ordes.json
  def create
    @order = @user.orders.build(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to customer_or_admin_orders_path, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ordes/1
  # PUT /ordes/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to customer_or_admin_orders_path, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordes/1
  # DELETE /ordes/1.json
  def destroy
    authenticate_admin!
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Order was deleted.' }
      format.json { head :no_content }
    end
  end

  def approve
    @order = @user.orders.find(params[:id])
    
    respond_to do |format|
      if @order.approver == @user
        @order.approved = true
        if @order.save 
          format.html { redirect_to :back, notice: 'Order was approved.' }
          format.json { render json: @order, status: :created, location: @order }
        else
          format.html { redirect_to :back, notice: 'Order was not approved.' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to :back, notice: 'You are not eligible to approve' }
      end
    end
  end

  def sent
    #maybe cant send until customer_approved?
    @order = Order.find(params[:id])

    @order.sent = true
    respond_to do |format|
      if @order.save
        UserMailer.order_sent(@order).deliver
        format.html { redirect_to :back, notice: 'Order was marked as sent.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { redirect_to :back, error: 'Order was not marked as sent.' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def all_orders
    @orders = Order.all
    render :index
  end

  def to_approve
    @orders = @user.orders_assigned_for_approval.where(:approved => false)
    render :index
  end

end
