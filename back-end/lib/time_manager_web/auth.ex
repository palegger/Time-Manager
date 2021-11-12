defmodule TodolistWeb.Auth do
  import Plug.Conn
  def init(opts), do: opts # maybe list the routes that need to be authenticated in opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    require Logger

    tokenHeader = Plug.Conn.get_req_header(conn, "security")
    {:ok, tokenValue} = Enum.fetch(tokenHeader, 0)
    with {:ok, claims} <- TodolistWeb.Token.verify(tokenValue)
    do
      conn
        |> assign(:tokenRole, claims["role"])
        |> assign(:tokenUserID, claims["userID"])
    else
      {:error, err} -> IO.puts(err)
      Plug.Conn.send_resp(conn, 401, "")
      conn
    end
  end
end
