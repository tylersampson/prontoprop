class OriginatorsController < ApplicationController
  before_action :set_originator, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Originator.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /originators
  # GET /originators.json
  def index
    add_breadcrumb I18n.t('listing', entity: Originator.model_name.human(count: 10))
    @q = policy_scope(Originator).ransack(params[:q])
    @originators = @q.result.page(params[:page]).per(session[:default_per])
  end

  # GET /originators/1
  # GET /originators/1.json
  def show
    authorize @originator
    add_breadcrumb @originator.name
  end

  # GET /originators/new
  def new
    @originator = Originator.new
    authorize @originator
    add_breadcrumb I18n.t('creating', entity: Originator.model_name.human)
  end

  # GET /originators/1/edit
  def edit
    authorize @originator
    add_breadcrumb @originator.name, @originator
    add_breadcrumb I18n.t('editing', entity: Originator.model_name.human)
  end

  # POST /originators
  # POST /originators.json
  def create
    @originator = Originator.new(originator_params)
    authorize @originator
    respond_to do |format|
      if @originator.save
        format.html { redirect_to (params[:save_and_new].present? ? new_originator_path : @originator), success: I18n.t('notices.created', entity: Originator.model_name.human, id: @originator.id) }
        format.json { render :show, status: :created, location: @originator }
      else
        format.html { render :new }
        format.json { render json: @originator.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /originators/1
  # PATCH/PUT /originators/1.json
  def update
    authorize @originator
    respond_to do |format|
      if @originator.update(originator_params)
        format.html { redirect_to @originator, success: I18n.t('notices.updated', entity: Originator.model_name.human, title: @originator.name) }
        format.json { render :show, status: :ok, location: @originator }
      else
        format.html { render :edit }
        format.json { render json: @originator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /originators/1
  # DELETE /originators/1.json
  def destroy
    authorize @originator
    @originator.destroy
    respond_to do |format|
      format.html { redirect_to originators_url, notice: 'Originator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_originator
      @originator = Originator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def originator_params
      params.require(:originator).permit(:name, :telephone, :email, :preferred)
    end
end
