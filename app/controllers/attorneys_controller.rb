class AttorneysController < ApplicationController
  before_action :set_attorney, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Attorney.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /attorneys
  # GET /attorneys.json
  def index
    add_breadcrumb I18n.t('listing', entity: Attorney.model_name.human(count: 10))
    @q = policy_scope(Attorney).ransack(params[:q])
    @attorneys = @q.result.page(params[:page]).per(session[:default_per])
  end

  # GET /attorneys/1
  # GET /attorneys/1.json
  def show
    authorize @attorney
    add_breadcrumb @attorney.name
  end

  # GET /attorneys/new
  def new
    @attorney = Attorney.new
    authorize @attorney
    add_breadcrumb I18n.t('creating', entity: Attorney.model_name.human)
  end

  # GET /attorneys/1/edit
  def edit
    authorize @attorney
    add_breadcrumb @attorney.name, @attorney
    add_breadcrumb I18n.t('editing', entity: Attorney.model_name.human)
  end

  # POST /attorneys
  # POST /attorneys.json
  def create
    @attorney = Attorney.new(attorney_params)
    authorize @attorney
    respond_to do |format|
      if @attorney.save
        format.html { redirect_to (params[:save_and_new].present? ? new_attorney_path : @attorney), success: I18n.t('notices.created', entity: Attorney.model_name.human, id: @attorney.id) }
        format.json { render :show, status: :created, location: @attorney }
      else
        format.html { render :new }
        format.json { render json: @attorney.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /attorneys/1
  # PATCH/PUT /attorneys/1.json
  def update
    authorize @attorney
    respond_to do |format|
      if @attorney.update(attorney_params)
        format.html { redirect_to @attorney, success: I18n.t('notices.updated', entity: Attorney.model_name.human, title: @attorney.name) }
        format.json { render :show, status: :ok, location: @attorney }
      else
        format.html { render :edit }
        format.json { render json: @attorney.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attorneys/1
  # DELETE /attorneys/1.json
  def destroy
    authorize @attorney
    @attorney.destroy
    respond_to do |format|
      format.html { redirect_to attorneys_url, notice: 'Attorney was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attorney
      @attorney = Attorney.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attorney_params
      params.require(:attorney).permit(:name, :telephone, :email, :preferred)
    end
end
