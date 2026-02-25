class Category < ApplicationRecord
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  COLORS = %w[blue red green emerald amber violet pink indigo teal].freeze

  COLOR_LABELS = {
    "blue" => "青",
    "red" => "赤",
    "green" => "緑",
    "emerald" => "エメラルド",
    "amber" => "琥珀",
    "violet" => "紫",
    "pink" => "ピンク",
    "indigo" => "インディゴ",
    "teal" => "ティール"
  }.freeze

  BADGE_CLASSES = {
    "blue" => "bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300 hover:bg-blue-200 dark:hover:bg-blue-900/50",
    "red" => "bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-300 hover:bg-red-200 dark:hover:bg-red-900/50",
    "green" => "bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-300 hover:bg-green-200 dark:hover:bg-green-900/50",
    "emerald" => "bg-emerald-100 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300 hover:bg-emerald-200 dark:hover:bg-emerald-900/50",
    "amber" => "bg-amber-100 dark:bg-amber-900/30 text-amber-700 dark:text-amber-300 hover:bg-amber-200 dark:hover:bg-amber-900/50",
    "violet" => "bg-violet-100 dark:bg-violet-900/30 text-violet-700 dark:text-violet-300 hover:bg-violet-200 dark:hover:bg-violet-900/50",
    "pink" => "bg-pink-100 dark:bg-pink-900/30 text-pink-700 dark:text-pink-300 hover:bg-pink-200 dark:hover:bg-pink-900/50",
    "indigo" => "bg-indigo-100 dark:bg-indigo-900/30 text-indigo-700 dark:text-indigo-300 hover:bg-indigo-200 dark:hover:bg-indigo-900/50",
    "teal" => "bg-teal-100 dark:bg-teal-900/30 text-teal-700 dark:text-teal-300 hover:bg-teal-200 dark:hover:bg-teal-900/50"
  }.freeze

  validates :name, presence: true, uniqueness: true
  validates :color, inclusion: { in: COLORS }, allow_nil: true

  def badge_classes
    BADGE_CLASSES[color.presence || "blue"]
  end
end
