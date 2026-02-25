# frozen_string_literal: true

# 本番環境のアセットデバッグ用（DEBUG_ASSETS=1 のときのみルートが有効）
class DebugController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :only_when_debug_enabled

  def assets_check
    assets_dir = Rails.root.join("public", "assets")
    css_files = assets_dir.exist? ? Dir.glob(assets_dir.join("*.css")).map { |f| File.basename(f) } : []

    render json: {
      assets_dir_exist: assets_dir.exist?,
      rails_root: Rails.root.to_s,
      css_count: css_files.size,
      sample_css: css_files.first(5)
    }
  end

  private

  def only_when_debug_enabled
    return head :not_found unless ENV["DEBUG_ASSETS"] == "1"
  end
end
