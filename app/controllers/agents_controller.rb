class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: Agent.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET /agents
  # GET /agents.json
  def index
    add_breadcrumb I18n.t('listing', entity: Agent.model_name.human(count: 10))
    @q = policy_scope(Agent).ransack(params[:q])
    @agents = @q.result.page(params[:page]).per(session[:default_per])
    respond_to do |format|
      format.html
      format.csv { send_data @agents.to_csv }
    end
  end

  def import
    total = Agent.import(params[:file])
    redirect_to agents_path, notice: "#{total} agents imported!"
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    authorize @agent
    add_breadcrumb @agent.first_name
  end

  # GET /agents/new
  def new
    @agent = Agent.new
    authorize @agent
    add_breadcrumb I18n.t('creating', entity: Agent.model_name.human)
  end

  # GET /agents/1/edit
  def edit
    authorize @agent
    add_breadcrumb @agent.first_name, @agent
    add_breadcrumb I18n.t('editing', entity: Agent.model_name.human)
  end

  # POST /agents
  # POST /agents.json
  def create
    @agent = Agent.new(agent_params)
    authorize @agent
    respond_to do |format|
      if @agent.save
        format.html { redirect_to (params[:save_and_new].present? ? new_agent_path : @agent), success: I18n.t('notices.created', entity: Agent.model_name.human, id: @agent.id) }
        format.json { render :show, status: :created, location: @agent }
      else
        format.html { render :new }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    authorize @agent
    respond_to do |format|
      if @agent.update(agent_params)
        format.html { redirect_to @agent, success: I18n.t('notices.updated', entity: Agent.model_name.human, title: @agent.first_name) }
        format.json { render :show, status: :ok, location: @agent }
      else
        format.html { render :edit }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    authorize @agent
    @agent.destroy
    respond_to do |format|
      format.html { redirect_to agents_url, notice: 'Agent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_params
      params.require(:agent).permit(:first_name, :last_name, :employee_number, :mobile, :email, :tax_percent)
    end
end
