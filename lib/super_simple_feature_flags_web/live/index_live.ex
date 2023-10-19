defmodule SuperSimpleFeatureFlagsWeb.IndexLive do
  use SuperSimpleFeatureFlagsWeb, :live_view
  alias SuperSimpleFeatureFlags.Persistence

  @impl true
  def render(assigns) do
    ~H"""
    <div class="prose">
      <.header>
        Features
      </.header>

      <div class="flow-root mt-6">
        <ul role="list" class="-mb-8">
          <li :for={feature <- @features}>
            <div class="relative pb-8">
              <div class="relative flex space-x-3">
                <div>
                  <span class={"h-8 w-8 rounded-full #{if feature.enabled, do: "bg-green-500", else: "bg-gray-200"} flex items-center justify-center ring-8 ring-white"}>
                    <svg
                      class="h-5 w-5 text-white"
                      viewBox="0 0 20 20"
                      fill="currentColor"
                      aria-hidden="true"
                    >
                      <path
                        fill-rule="evenodd"
                        d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
                        clip-rule="evenodd"
                      />
                    </svg>
                  </span>
                </div>
                <div class="flex min-w-0 flex-1 justify-between space-x-4 pt-1.5">
                  <div>
                    <p class="text-sm text-gray-500">
                      <span href="#" class="font-medium text-gray-900"><%= feature.name %></span>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Features")
      |> assign(:features, Persistence.list_features())

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("toggle_feature", _params, socket) do
    {:noreply, socket}
  end
end
