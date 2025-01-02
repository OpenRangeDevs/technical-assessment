class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    @admins = Admin.all

    if params[:query].present?
      @admins = @admins.search(params[:query])
    end
  end

  def show
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to @admin, notice: 'Admin was succesfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @admin.update(admin_params)
      redirect_to @admin, notice: 'Admin was succussfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admin.destroy
    redirect_to admins_url, notice: 'Admin was successfully deleted.'
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:name, :e-mail, :phone, :role_level, :active_status, :admin_code)
  end
end
