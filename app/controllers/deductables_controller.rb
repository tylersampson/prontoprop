class DeductablesController < ApplicationController
  before_action :set_deductable, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Deductable.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /deductables
  # GET /deductables.json
  def index
    add_breadcrumb I18n.t('listing', entity: Deductable.model_name.human(count: 10))
    @q = policy_scope(Deductable).ransack(params[:q])
    @deductables = @q.result.page(params[:page]).per(session[:default_per])
  end

  # GET /deductables/1
  # GET /deductables/1.json
  def show
    authorize @deductable
    add_breadcrumb @deductable.name
  end

  # GET /deductables/new
  def new
    @deductable = Deductable.new
    authorize @deductable
    add_breadcrumb I18n.t('creating', entity: Deductable.model_name.human)
  end

  # GET /deductables/1/edit
  def edit
    authorize @deductable
    add_breadcrumb @deductable.name, @deductable
    add_breadcrumb I18n.t('editing', entity: Deductable.model_name.human)
  end

  # POST /deductables
  # POST /deductables.json
  def create
    @deductable = Deductable.new(deductable_params)
    authorize @deductable
    respond_to do |format|
      if @deductable.save
        format.html { redirect_to (params[:save_and_new].present? ? new_deductable_path : @deductable), success: I18n.t('notices.created', entity: Deductable.model_name.human, id: @deductable.id) }
        format.json { render :show, status: :created, location: @deductable }
      else
        format.html { render :new }
        format.json { render json: @deductable.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /deductables/1
  # PATCH/PUT /deductables/1.json
  def update
    authorize @deductable
    respond_to do |format|
      if @deductable.update(deductable_params)
        format.html { redirect_to @deductable, success: I18n.t('notices.updated', entity: Deductable.model_name.human, title: @deductable.name) }
        format.json { render :show, status: :ok, location: @deductable }
      else
        format.html { render :edit }
        format.json { render json: @deductable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deductables/1
  # DELETE /deductables/1.json
  def destroy
    authorize @deductable
    @deductable.destroy
    respond_to do |format|
      format.html { redirect_to deductables_url, notice: 'Deductable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deductable
      @deductable = Deductable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deductable_params
      params.require(:deductable).permit(:name, :default_cost)
    end
end
