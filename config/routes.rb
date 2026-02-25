Rails.application.routes.draw do
  # デバッグ: 本番でアセットが存在するか確認（DEBUG_ASSETS=1 のときのみ有効）
  if Rails.env.production? && ENV["DEBUG_ASSETS"] == "1"
    get "/_assets_check", to: "debug#assets_check"
  end

  get "about", to: "home#about", as: :about
  resources :categories
  resources :posts
  root "home#index"
end
