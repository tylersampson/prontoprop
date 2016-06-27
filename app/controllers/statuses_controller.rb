class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Status.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /statuses
  # GET /statuses.json
  def index
    add_breadcrumb I18n.t('listing', entity: Status.model_name.human(count: 10))
    @q = policy_scope(Status).ransack(params[:q])
    @statuses = @q.result.page(params[:page]).per(session[:default_per])
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    authorize @status
    add_breadcrumb @status.name
  end

  # GET /statuses/new
  def new
    @status = Status.new
    authorize @status
    add_breadcrumb I18n.t('creating', entity: Status.model_name.human)
  end

  # GET /statuses/1/edit
  def edit
    authorize @status
    add_breadcrumb @status.name, @status
    add_breadcrumb I18n.t('editing', entity: Status.model_name.human)
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(status_params)
    authorize @status
    respond_to do |format|
      if @status.save
        format.html { redirect_to (params[:save_and_new].present? ? new_status_path : @status), success: I18n.t('notices.created', entity: Status.model_name.human, id: @status.id) }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    authorize @status
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, success: I18n.t('notices.updated', entity: Status.model_name.human, title: @status.name) }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    authorize @status
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:name, :nature, :can_edit)
    end
end
