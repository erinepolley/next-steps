defmodule ReturnCalculator do
  alias NextSteps.ReturnInput

  def calculate_return(
        # %{
        #   starting_amount: starting_amount,
        #   annual_contribution: annual_contribution,
        #   annual_growth_rate: annual_growth_rate,
        #   years: years
        # } = return_input_attrs
        # ) do
        return_input_attrs
      ) do
    case Ash.create(ReturnInput, return_input_attrs) do
      {:ok, changeset} ->
        do_calculate_return(changeset)

      {:error, changeset} ->
        changeset
    end
  end

  defp do_calculate_return(
         %{
           starting_amount: starting_amount,
           annual_contribution: annual_contribution,
           annual_growth_rate: annual_growth_rate,
           years: years
         } = _changeset
       ) do
    future_value =
      starting_amount * :math.pow(1 + annual_growth_rate, years) +
        annual_contribution *
          ((:math.pow(1 + annual_growth_rate, years) - 1) / annual_growth_rate)

    Float.round(future_value, 0)
  end
end
