class CreateShortenedUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false
      t.string :short_url, null: false
      t.references :user, foreign: true

      t.index :short_url, unique: true
      t.timestamps
    end
  end
end
