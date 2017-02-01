defmodule DevReading.Article do
  use DevReading.Web, :model

  schema "articles" do
    field :title,         :string
    field :url,           :string
    field :issue,         :integer
    field :ps,            :string
    field :html,          :string
    field :article_html,  :string
    field :article_text,  :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :url, :article_html])
    |> validate_required([:title, :url, :article_html])
  end
end
