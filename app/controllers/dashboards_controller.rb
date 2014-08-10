require 'table_script'
class DashboardsController < ApplicationController
  def index
    @data_table = TableScript::HtmlTable.new.scrap_table
    @htm_table = TableScript::HtmlTable.new.generate_table(@data_table)
  end

  def sample_table

  end
end
