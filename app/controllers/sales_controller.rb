class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Sale.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /sales
  # GET /sales.json
  def index
    add_breadcrumb I18n.t('listing', entity: Sale.model_name.human(count: 10))
    @q = policy_scope(Sale).ransack(params[:q])
    @sales = @q.result.includes(:buyer).includes(:seller).includes(:attorney).includes(:bond_attorney).page(params[:page]).per(session[:default_per])
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
    authorize @sale
    add_breadcrumb @sale.reference
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    authorize @sale
    @sale.build_address
    @sale.build_buyer
    @sale.build_seller
    add_breadcrumb I18n.t('creating', entity: Sale.model_name.human)
  end

  # GET /sales/1/edit
  def edit
    authorize @sale
    add_breadcrumb @sale.reference, @sale
    add_breadcrumb I18n.t('editing', entity: Sale.model_name.human)
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    authorize @sale
    respond_to do |format|
      if @sale.save
        format.html { redirect_to (params[:save_and_new].present? ? new_sale_path : @sale), success: I18n.t('notices.created', entity: Sale.model_name.human, id: @sale.id) }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    authorize @sale
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, success: I18n.t('notices.updated', entity: Sale.model_name.human, title: @sale.reference) }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    authorize @sale
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:reference, :seller_id, :buyer_id, :contract_start_on, :purchase_price, :deposit_amount, :deposit_due_on, :attorney_id, :bond_attorney_id, :bond_due_on, :originator_id, :status_id, :registered_on, :bank_id, :grant_amount, :commission_amount, :seller_attributes => [:id, :first_name, :last_name, :email, :mobile, :company], :buyer_attributes => [:id, :first_name, :last_name, :email, :mobile, :company], :address_attributes => [:id, :erf, :street_number, :street_name, :unit, :complex, :suburb, :city, :post_code], :commissions_attributes => [:id, :agent_id, :agent_percent, :_destroy, :deductions_attributes => [:id, :deductable_id, :name, :total_amount]])
    end
end
