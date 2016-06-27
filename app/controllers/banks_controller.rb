class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Bank.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /banks
  # GET /banks.json
  def index
    add_breadcrumb I18n.t('listing', entity: Bank.model_name.human(count: 10))
    @q = policy_scope(Bank).ransack(params[:q])
    @banks = @q.result.page(params[:page]).per(session[:default_per])
  end

  # GET /banks/1
  # GET /banks/1.json
  def show
    authorize @bank
    add_breadcrumb @bank.name
  end

  # GET /banks/new
  def new
    @bank = Bank.new
    authorize @bank
    add_breadcrumb I18n.t('creating', entity: Bank.model_name.human)
  end

  # GET /banks/1/edit
  def edit
    authorize @bank
    add_breadcrumb @bank.name, @bank
    add_breadcrumb I18n.t('editing', entity: Bank.model_name.human)
  end

  # POST /banks
  # POST /banks.json
  def create
    @bank = Bank.new(bank_params)
    authorize @bank
    respond_to do |format|
      if @bank.save
        format.html { redirect_to (params[:save_and_new].present? ? new_bank_path : @bank), success: I18n.t('notices.created', entity: Bank.model_name.human, id: @bank.id) }
        format.json { render :show, status: :created, location: @bank }
      else
        format.html { render :new }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  def update
    authorize @bank
    respond_to do |format|
      if @bank.update(bank_params)
        format.html { redirect_to @bank, success: I18n.t('notices.updated', entity: Bank.model_name.human, title: @bank.name) }
        format.json { render :show, status: :ok, location: @bank }
      else
        format.html { render :edit }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    authorize @bank
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to banks_url, notice: 'Bank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_params
      params.require(:bank).permit(:name)
    end
end
