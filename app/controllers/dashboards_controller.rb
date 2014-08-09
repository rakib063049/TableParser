require 'table_script'
class DashboardsController < ApplicationController
  def index
    table_scrap = TableScript::Sucks.new
    @data_table = table_scrap.scrap
  end

  def sample_table

  end
end
