class CrudCostumersController < ApplicationController
  # GET /costumers
  # GET /costumers.json
  def index
    @costumers = Costumer.all

    render 'costumers/index'
  end

  # GET /costumers/1
  # GET /costumers/1.json
  def show
    @costumer = Costumer.find(params[:id])
    render :action => :edit
  end

  # GET /costumers/new
  # GET /costumers/new.json
  # def new
  #   @costumer = Costumer.new

  #   render 'costumers/new'
  # end

  # GET /costumers/1/edit
  def edit
    @costumer = Costumer.find(params[:id])
  end

  # POST /costumers
  # POST /costumers.json
  def create
    @costumer = Costumer.new(params[:costumer])

    respond_to do |format|
      if @costumer.save
        format.html { redirect_to @costumer, notice: 'Costumer was successfully created.' }
        format.json { render json: @costumer, status: :created, location: @costumer }
      else
        format.html { render action: "new" }
        format.json { render json: @costumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /costumers/1
  # PUT /costumers/1.json
  def update
    @costumer = Costumer.find(params[:id])

    respond_to do |format|
      if @costumer.update_attributes(params[:costumer])
        format.html { redirect_to @costumer, notice: 'Costumer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @costumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /costumers/1
  # DELETE /costumers/1.json
  def destroy
    @costumer = Costumer.find(params[:id])
    @costumer.destroy

    respond_to do |format|
      format.html { redirect_to costumers_url }
      format.json { head :no_content }
    end
  end
end
