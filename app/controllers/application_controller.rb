class ApplicationController < ActionController::Base
  # 自定义注册/登入后跳转页面
  def after_sign_in_path_for(resource)
    todos_path
  end

  def after_sign_up_path_for(resource)
    todos_path
  end
end
