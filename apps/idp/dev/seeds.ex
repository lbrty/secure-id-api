defmodule Idp.Seeds do
  alias Idp.{Permissions, Projects, Users}
  alias Idp.Seeds.Geo

  def run() do
    Geo.run()

    Users.register_user(%{email: "admin@email.com", full_name: "Admin", password: "12345678", is_superuser: true, is_active: true})
    {:ok, user1} = Users.register_user(%{email: "user1@email.com", full_name: "User 1", password: "12345678", is_superuser: false, is_active: true})
    {:ok, user2} = Users.register_user(%{email: "user2@email.com", full_name: "User 2", password: "12345678", is_superuser: false, is_active: true})
    {:ok, user3} = Users.register_user(%{email: "user3@email.com", full_name: "User 3", password: "12345678", is_superuser: false, is_active: true})
    Users.register_user(%{email: "user4@email.com", full_name: "User 4", password: "12345678", is_superuser: false, is_active: true})
    {:ok, user5} = Users.register_user(%{email: "user5@email.com", full_name: "User 5", password: "12345678", is_superuser: false, is_active: true})

    Users.register_user(%{email: "admin2@email.com", full_name: "User 6", password: "12345678", is_superuser: true, is_active: true})
    Users.register_user(%{email: "inactive@email.com", full_name: "Inactive user 1", password: "12345678", is_superuser: false, is_active: false})

    ## Projects
    # admin
    {:ok, project1} = Projects.create_project(%{name: "Project X", description: "Project X description admin"})

    Projects.create_project(%{name: "Project Y", description: "Project Y description admin"})
    Projects.create_project(%{name: "Project Z", description: "Project Z description admin"})
    Projects.create_project(%{name: "Project A", description: "Project A description admin"})

    ## Permissions
    Permissions.create_permission(%{
      is_admin: false,
      can_create: true,
      can_read: true,
      can_update: true,
      can_delete: true,
      view_contacts: true,
      view_personal: true,
      view_documents: true,
      user_id: user1.id,
      project_id: project1.id
    })

    Permissions.create_permission(%{
      is_admin: false,
      can_create: true,
      can_read: true,
      can_update: true,
      can_delete: true,
      view_contacts: true,
      view_personal: true,
      view_documents: true,
      user_id: user2.id,
      project_id: project1.id
    })

    Permissions.create_permission(%{
      is_admin: false,
      can_create: true,
      can_read: true,
      can_update: true,
      can_delete: true,
      view_contacts: true,
      view_personal: true,
      view_documents: true,
      user_id: user3.id,
      project_id: project1.id
    })

    Permissions.create_permission(%{
      is_admin: true,
      can_create: true,
      can_read: true,
      can_update: true,
      can_delete: true,
      view_contacts: true,
      view_personal: true,
      view_documents: true,
      user_id: user5.id,
      project_id: project1.id
    })
  end
end
