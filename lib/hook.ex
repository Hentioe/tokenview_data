defmodule TokenviewData.Hook do
  @moduledoc false

  @callback call(params :: map) :: no_return()
end
