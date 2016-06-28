class LeasesController < ApplicationController
  before_action :set_lease, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Lease.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /leases
  # GET /leases.json
  def index
    add_breadcrumb I18n.t('listing', entity: Lease.model_name.human(count: 10))
    @q = policy_scope(Lease).ransack(params[:q])
    @leases = @q.result.page(params[:page]).per(session[:default_per])
  end

  # GET /leases/1
  # GET /leases/1.json
  def show
    authorize @lease
    add_breadcrumb @lease.reference
  end

  # GET /leases/new
  def new
    @lease = Lease.new
    authorize @lease
    @lease.build_lessor
    @lease.build_lessee
    @lease.build_address
    add_breadcrumb I18n.t('creating', entity: Lease.model_name.human)
  end

  # GET /leases/1/edit
  def edit
    authorize @lease
    add_breadcrumb @lease.reference, @lease
    add_breadcrumb I18n.t('editing', entity: Lease.model_name.human)
  end

  # POST /leases
  # POST /leases.json
  def create
    @lease = Lease.new(lease_params)
    authorize @lease
    respond_to do |format|
      if @lease.save
        format.html { redirect_to (params[:save_and_new].present? ? new_lease_path : @lease), success: I18n.t('notices.created', entity: Lease.model_name.human, id: @lease.id) }
        format.json { render :show, status: :created, location: @lease }
      else
        format.html { render :new }
        format.json { render json: @lease.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /leases/1
  # PATCH/PUT /leases/1.json
  def update
    authorize @lease
    respond_to do |format|
      if @lease.update(lease_params)
        format.html { redirect_to @lease, success: I18n.t('notices.updated', entity: Lease.model_name.human, title: @lease.reference) }
        format.json { render :show, status: :ok, location: @lease }
      else
        format.html { render :edit }
        format.json { render json: @lease.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leases/1
  # DELETE /leases/1.json
  def destroy
    authorize @lease
    @lease.destroy
    respond_to do |format|
      format.html { redirect_to leases_url, notice: 'Lease was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lease
      @lease = Lease.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lease_params
      params.require(:lease).permit(:reference, :payprop_reference, :rent_amount, :managed, :start_on, :end_on, :deposit_amount, :deposit_held_by, :lessor_id, :lessee_id, :lease_fee, :inspection_fee, :credit_check_fee, :credit_check_on, :deposit_released_on, :deposit_released_to, :agent_id, :lessor_attributes => [:id, :first_name, :last_name, :email, :mobile, :company], :lessee_attributes => [:id, :first_name, :last_name, :email, :mobile, :company], :address_attributes => [:id, :erf, :street_number, :street_name, :unit, :complex, :suburb, :city, :post_code])
    end
end
