<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"
<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('listing', entity: <%= class_name %>.model_name.human(count: 10)), :saved_index_path, except: :index

  # GET <%= route_url %>
  # GET <%= route_url %>.json
  def index
    add_breadcrumb I18n.t('listing', entity: <%= class_name %>.model_name.human(count: 10))
    @q = policy_scope(<%= class_name %>).ransack(params[:q])
    @<%= plural_table_name %> = @q.result.page(params[:page]).per(session[:default_per])
  end

  # GET <%= route_url %>/1
  # GET <%= route_url %>/1.json
  def show
    authorize @<%= singular_table_name %>
    add_breadcrumb @<%= singular_table_name %>.<%= attributes.first.name %>
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    authorize @<%= singular_table_name %>
    add_breadcrumb I18n.t('creating', entity: <%= class_name %>.model_name.human)
  end

  # GET <%= route_url %>/1/edit
  def edit
    authorize @<%= singular_table_name %>
    add_breadcrumb @<%= singular_table_name %>.<%= attributes.first.name %>, @<%= singular_table_name %>
    add_breadcrumb I18n.t('editing', entity: <%= class_name %>.model_name.human)
  end

  # POST <%= route_url %>
  # POST <%= route_url %>.json
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
    authorize @<%= singular_table_name %>
    respond_to do |format|
      if @<%= orm_instance.save %>
        format.html { redirect_to (params[:save_and_new].present? ? new_<%= singular_table_name %>_path : @<%= singular_table_name %>), success: I18n.t('notices.created', entity: <%= class_name %>.model_name.human, id: @<%= singular_table_name %>.id) }
        format.json { render :show, status: :created, location: <%= "@#{singular_table_name}" %> }
      else
        format.html { render :new }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT <%= route_url %>/1
  # PATCH/PUT <%= route_url %>/1.json
  def update
    authorize @<%= singular_table_name %>
    respond_to do |format|
      if @<%= orm_instance.update("#{singular_table_name}_params") %>
        format.html { redirect_to @<%= singular_table_name %>, success: I18n.t('notices.updated', entity: <%= class_name %>.model_name.human, title: @<%= singular_table_name %>.<%= attributes.first.name %>) }
        format.json { render :show, status: :ok, location: <%= "@#{singular_table_name}" %> }
      else
        format.html { render :edit }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
      end
    end
  end

  # DELETE <%= route_url %>/1
  # DELETE <%= route_url %>/1.json
  def destroy
    authorize @<%= singular_table_name %>
    @<%= orm_instance.destroy %>
    respond_to do |format|
      format.html { redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} was successfully destroyed.'" %> }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(<%= ":#{singular_table_name}" %>, {})
      <%- else -%>
      params.require(<%= ":#{singular_table_name}" %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
