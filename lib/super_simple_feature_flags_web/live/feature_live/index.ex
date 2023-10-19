defmodule SuperSimpleFeatureFlagsWeb.FeatureLive.Index do
  use SuperSimpleFeatureFlagsWeb, :live_view

  alias SuperSimpleFeatureFlags.Persistence
  alias SuperSimpleFeatureFlags.Persistence.Feature

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :features, Persistence.list_features())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Feature")
    |> assign(:feature, Persistence.get_feature!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Feature")
    |> assign(:feature, %Feature{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Features")
    |> assign(:feature, nil)
  end

  @impl true
  def handle_info(
        {SuperSimpleFeatureFlagsWeb.FeatureLive.FormComponent, {:saved, feature}},
        socket
      ) do
    {:noreply, stream_insert(socket, :features, feature)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    feature = Persistence.get_feature!(id)
    {:ok, _} = Persistence.delete_feature(feature)

    {:noreply, stream_delete(socket, :features, feature)}
  end

  @impl Phoenix.LiveView
  def handle_event("toggle_feature", %{"id" => id} = params, socket) do
    {:ok, feature} =
      id
      |> Persistence.get_feature!()
      |> Persistence.update_feature(%{enabled: params["value"] != "true"})

    {:noreply, stream_insert(socket, :features, feature)}
  end
end
