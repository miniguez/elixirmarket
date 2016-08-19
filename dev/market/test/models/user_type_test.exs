defmodule Market.UserTypeTest do
  use Market.ModelCase

  alias Market.UserType

  @valid_attrs %{type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserType.changeset(%UserType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserType.changeset(%UserType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
