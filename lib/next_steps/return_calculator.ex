defmodule ReturnCalculator do
  alias NextSteps.ReturnInput

  def calculate_return(
        # %{
        #   starting_amount: starting_amount,
        #   annual_contribution: annual_contribution,
        #   annual_rate_of_return: annual_rate_of_return,
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
           annual_rate_of_return: annual_rate_of_return,
           years: years
         } = _changeset
       ) do
    interest_rate = :math.pow(1 + annual_rate_of_return, years)

    future_value =
      starting_amount * interest_rate +
        annual_contribution *
          ((interest_rate - 1) / annual_rate_of_return)

    Float.round(future_value, 0)
  end
end
