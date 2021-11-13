defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  def call(conn, {:error, :bad_request, message_string}) when is_binary(message_string) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiWeb.ErrorView)
    |> render("custom_error_message.json", message: message_string)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ApiWeb.ErrorView)
    |> render(:"401")
  end
end
