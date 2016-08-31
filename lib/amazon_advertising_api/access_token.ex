defmodule AmazonAdvertisingApi.AccessToken do
  @moduledoc false

  use HTTPoison.Base

  def valid?(profile_id, access_token) do
    access_token
    |> process_url
    |> call_api(profile_id)
    |> process_response
  end

  defp process_url(access_token) do
    "https://api.amazon.com/auth/O2/tokeninfo?access_token=" <> access_token
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    IO.puts body
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: 400, body: body}}) do
    IO.puts body
    # "invalid_token" != body |> Poison.decode! |> Map.get("error")
  end

  defp process_response({:error, %HTTPoison.Error{reason: reason}}) do
    IO.inspect reason
  end

  defp process_response(results) do
    IO.inspect results
  end

  defp call_api(url, profile_id) do
    get url, [
      {"User-Agent", "application/json"},
      {"Amazon-Advertising-API-Scope", profile_id}
    ]
  end
end