defmodule Idp.Seeds.Geo do
  alias Idp.Geo.{Countries, States, Cities}

  def run do
    {:ok, de} = Countries.create_country(%{name: "Germany"})
    {:ok, kg} = Countries.create_country(%{name: "Kyrgyzstan"})

    {:ok, ber} = States.create_state(%{
      name: "Berlin",
      country_id: de.id
    })

    Cities.create_city(%{
      name: "Berlin",
      state_id: ber.id
    })

    {:ok, ch} = States.create_state(%{
      name: "Chuy",
      country_id: kg.id
    })

    Cities.create_city(%{
      name: "Bishkek",
      state_id: ch.id
    })
  end
end
