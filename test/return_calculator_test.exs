defmodule ReturnCalculatorTest do
  use ExUnit.Case
  alias ReturnCalculator

  @valid_attrs %{
    starting_amount: 10_000,
    annual_contribution: 5_000,
    annual_rate_of_return: 0.07,
    years: 20
  }

  test "calculate_return/1 calculates the future value correctly" do
    result = ReturnCalculator.calculate_return(@valid_attrs)
    assert result == 243_674
  end

  test "returns error if invalid growth rate precision" do
    changeset =
      @valid_attrs
      |> Map.put(:annual_rate_of_return, 0.0275)
      |> ReturnCalculator.calculate_return()

    assert error_message_on_field(changeset, :annual_rate_of_return) ==
             "cannot have more than 2 decimal places"
  end

  test "returns error if invalid annual contribution" do
    changeset =
      @valid_attrs
      |> Map.put(:annual_contribution, -500)
      |> ReturnCalculator.calculate_return()

    assert error_message_on_field(changeset, :annual_contribution) ==
             "must be greater than or equal to %{greater_than_or_equal_to}"
  end

  test "returns error if missing attr" do
    %{errors: [%Ash.Error.Changes.Required{} = error_struct]} =
      @valid_attrs
      |> Map.delete(:annual_rate_of_return)
      |> ReturnCalculator.calculate_return()

    assert error_struct.field == :annual_rate_of_return
  end

  defp error_message_on_field(%{valid?: true}, _field), do: nil

  defp error_message_on_field(changeset, field) do
    changeset
    |> error_on_field?(field)
    |> find_message()
  end

  defp error_on_field?(changeset, field) do
    Enum.find(changeset.errors, fn error -> error.field == field end)
  end

  defp find_message(nil), do: nil
  defp find_message(error), do: error.message
end
