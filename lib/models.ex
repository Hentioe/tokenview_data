defmodule TokenviewData.Models do
  @moduledoc false

  defmodule Response do
    @moduledoc false

    defstruct [:status_code, :code, :msg, :data]

    @type t :: %__MODULE__{
            status_code: integer,
            code: integer,
            msg: String.t(),
            data: any
          }
  end

  defmodule ApiError do
    @moduledoc false

    defstruct [:code, :msg]

    @type t :: %__MODULE__{
            code: integer,
            msg: String.t()
          }
  end

  defmodule RequestError do
    @moduledoc false

    defstruct [:reason, :msg]

    @type t :: %__MODULE__{
            reason: atom,
            msg: String.t()
          }
  end
end
