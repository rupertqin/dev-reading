defmodule DevReading.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :url, :string
      add :content, :text

      timestamps()
    end

  end
end
