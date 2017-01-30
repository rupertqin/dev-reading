defmodule DevReading.ArticleController do
  use DevReading.Web, :controller

  alias DevReading.Article
  alias DevReading.User
  import Paginator
  import Util

  plug :authen when action in [:edit, :update, :create, :delete]

  def index(conn, _params) do
    page = (_params["page"]|| 0) |> to_int
    page_size = (_params["page_size"] || 10) |> to_int
    count = Article |> Repo.aggregate(:count, :id)
    total_pages = total_pages(Article, page_size)
    articles = Article |> order_by_id(page, page_size) |> Repo.all
    render(conn, "index.html", articles: articles, count: count, page: page, total_pages: total_pages, _params: _params)
  end

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"article" => article_params}) do
    changeset = Article.changeset(%Article{}, article_params)

    case Repo.insert(changeset) do
      {:ok, _article} ->
        conn
        |> put_flash(:info, "Article created successfully.")
        |> redirect(to: article_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)
    render(conn, "show.html", article: article)
  end


  def edit(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)
    changeset = Article.changeset(article)
    render(conn, "edit.html", article: article, changeset: changeset)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Repo.get!(Article, id)
    changeset = Article.changeset(article, article_params)

    case Repo.update(changeset) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated successfully.")
        |> redirect(to: article_path(conn, :show, article))
      {:error, changeset} ->
        render(conn, "edit.html", article: article, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(article)

    conn
    |> put_flash(:info, "Article deleted successfully.")
    |> redirect(to: article_path(conn, :index))
  end

  def authen(conn, _) do
    user = Repo.get_by!(User, name: "rupert")
    message = get_session(conn, :message)
    if user.age != message do
      conn |> redirect(to: "/404") |> halt
    else
      conn
    end
  end
end
