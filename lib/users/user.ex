defmodule Flightex.Users.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys

  defstruct @keys

  def build(id, name, email, cpf) do
    user = %__MODULE__{
      id: id,
      name: name,
      email: email,
      cpf: cpf
    }

    {:ok, user}
  end

  def build(name, email, cpf) when is_bitstring(cpf) do
    id = UUID.uuid4()

    build(id, name, email, cpf)
  end

  def build(_name, _email, cpf) when is_integer(cpf), do: {:error, "Cpf must be a String"}
  def build(_name, _email, _cpf), do: {:error, "Invalid Parameters"}
end
