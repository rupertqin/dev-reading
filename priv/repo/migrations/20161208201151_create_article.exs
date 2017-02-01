defmodule DevReading.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title,         :string
      add :url,           :string
      add :issue,         :integer
      add :ps,            :text
      add :html,          :text
      add :article_html,  :text
      add :article_text,  :text

      timestamps()
    end

  end
end
