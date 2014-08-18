require 'table_script'
class DashboardsController < ApplicationController

  def index
    parser = TableScript::HtmlTable.new
    #Step#1
    @step1 = parser.generate_table

    #Step#2
    @step2 = parser.generate_table({delete_column: 3})

    #Step#3
    @step3 = parser.regenerate_array
  end

  def sample_table

  end
end
