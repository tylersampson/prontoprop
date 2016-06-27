class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Rental.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /rentals
  # GET /rentals.json
  def index
    add_breadcrumb I18n.t('listing', entity: Rental.model_name.human(count: 10))
    @q = policy_scope(Rental).ransack(params[:q])
    @rentals = @q.result.page(params[:page]).per(session[:default_per])
  end

  def import
    total,complete = Rental.import(params[:file])
    redirect_to rentals_path, notice: "#{complete}/#{total} imported"
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
    authorize @rental
    add_breadcrumb @rental.lease
  end

  # GET /rentals/new
  def new
    @rental = Rental.new
    authorize @rental
    add_breadcrumb I18n.t('creating', entity: Rental.model_name.human)
  end

  # GET /rentals/1/edit
  def edit
    authorize @rental
    add_breadcrumb @rental.lease, @rental
    add_breadcrumb I18n.t('editing', entity: Rental.model_name.human)
  end

  # POST /rentals
  # POST /rentals.json
  def create
    @rental = Rental.new(rental_params)
    authorize @rental
    respond_to do |format|
      if @rental.save
        format.html { redirect_to (params[:save_and_new].present? ? new_rental_path : @rental), success: I18n.t('notices.created', entity: Rental.model_name.human, id: @rental.id) }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /rentals/1
  # PATCH/PUT /rentals/1.json
  def update
    authorize @rental
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to @rental, success: I18n.t('notices.updated', entity: Rental.model_name.human, title: @rental.lease) }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # DELETE /rentals/1.json
  def destroy
    authorize @rental
    @rental.destroy
    respond_to do |format|
      format.html { redirect_to rentals_url, notice: 'Rental was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      params.require(:rental).permit(:lease_id, :received_on, :amount_received, :commission_amount, :tax_amount, :fees_amount)
    end
end
