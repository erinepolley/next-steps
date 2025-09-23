defmodule NextSteps.Validations.GrowthRatePrecision do
  use Ash.Resource.Validation

  @impl true
  def init(opts) do
    if opts[:attribute] != nil && is_atom(opts[:attribute]) do
      {:ok, opts}
    else
      {:error, "attribute must be an atom!"}
    end
  end

  @impl true
  def validate(%{valid?: false} = _changeset, _opts, _context), do: :ok

  def validate(changeset, opts, _context) do
    case Ash.Changeset.get_attribute(changeset, opts[:attribute]) do
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
          {:error, field: opts[:attribute], message: "cannot have more than 2 decimal places"}
        end
    end
  end
end
