defmodule TimeManagerWeb.Token do
    use Joken.Config

    def token_config do
        %{}
        |> add_claim("exp", fn -> 200 end, &(&1 == 200))
    end

    def signer() do
        signer = Joken.Signer.create("HS256", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9")
    end

    def decode(conn) do
        case extract_token(conn) do
        {:ok, token} -> TimeManagerWeb.Token.verify_and_validate(token, signer) 
        {:error, message} -> IO.puts "hello"
        end
    end
    
    defp extract_token(conn) do
        case Plug.Conn.get_req_header(conn, "authorization") do
        [auth_header] -> get_token_from_header(auth_header)
        _ -> {:error, :missing_auth_header}
        end
    end

    defp get_token_from_header(auth_header) do
        {:ok, reg} = Regex.compile("Bearer\:?\s+(.*)$", "i")
        case Regex.run(reg, auth_header) do
        [_, match] -> {:ok, String.trim(match)}
        _ -> {:error, "token not found"}
        end
    end

end