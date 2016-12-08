defmodule DevReading.Article do
  use DevReading.Web, :model

  schema "articles" do
    field :title, :string
    field :url, :string
    field :content, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :url, :content])
    |> validate_required([:title, :url, :content])
  end
end
