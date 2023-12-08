{:ok, _} = Application.ensure_all_started(:req)
{:ok, _} = Application.ensure_all_started(:inets)
{:ok, _} = Application.ensure_all_started(:hackney)
