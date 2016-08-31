defmodule AmazonAdvertisingApi do
  @moduledoc false

  # alias AmazonAdvertisingApi.Config

  # @scheme "http"
  # @host "webservices.amazon.com"
  # @path "/onca/xml"
  # @api_version "v1"
  # @application_version "1.0"

  def access_token_valid?(access_token) do
    case access_token |> token_info_url |> HttpPoison.get do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp token_info_url(access_token) do
    "https://api.amazon.com/auth/O2/tokeninfo?access_token=" <> access_token
  end

end
