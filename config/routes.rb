TableScript::Application.routes.draw do
  resource :dashboards do
    collection do
      get 'sample_table'
    end
  end
  root 'dashboards#index'
end
