defmodule Paginator do
  import Ecto.Query
  alias DevReading.Repo

  def order_by_id(query) do
    from p in query,
      order_by: [desc: p.id],
      limit: 5
  end

  def total_pages(query, page_size) do
    count = query
    |> exclude(:order_by)
    |> exclude(:preload)
    |> exclude(:select)
    |> select([e], count(e.id))
    |> Repo.one

    count/page_size
    |> Float.ceil
    |> trunc
  end

end
