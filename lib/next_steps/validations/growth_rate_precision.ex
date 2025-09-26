defmodule NextSteps.Validations.GrowthRatePrecision do
  use Ash.Resource.Validation

  @impl true
  def init(opts) do
    if !is_nil(opts[:annual_rate_of_return]) && is_atom(opts[:annual_rate_of_return]) do
      {:ok, opts}
    else
      {:error, "annual rate of return must be an atom!"}
    end
  end

  @impl true
  def validate(%{valid?: false} = _changeset, _opts, _context), do: :ok

  def validate(changeset, opts, _context) do
    case Ash.Changeset.get_attribute(changeset, opts[:annual_rate_of_return]) do
      # If growth rate precision is missing, the required validation will catch it after this
      nil ->
        :ok

      growth_rate ->
        decimal_places =
          growth_rate
          |> Float.to_string()
          |> String.split(".")
          |> List.last()
          |> String.length()

        if decimal_places <= 2 do
          :ok
        else
          {:error,
           field: opts[:annual_rate_of_return], message: "cannot have more than 2 decimal places"}
        end
    end
  end
end
