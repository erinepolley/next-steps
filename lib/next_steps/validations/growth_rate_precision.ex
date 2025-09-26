defmodule NextSteps.Validations.GrowthRatePrecision do
  @moduledoc """
  This validation ensures that the annual rate of return does not have more than
  two decimal places. Having a larger precision isn't a big deal in reality--the
  calculation would still function no matter what the precision--but the real
  purpose is I wanted to try creating a custom validation in Ash.
  """
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
      # If growth rate precision attr is missing, the required validation will catch it after this
      nil ->
        :ok

      growth_rate ->
        if Decimal.scale(growth_rate) <= 2 do
          :ok
        else
          {:error,
           field: opts[:annual_rate_of_return], message: "cannot have more than 2 decimal places"}
        end
    end
  end
end
