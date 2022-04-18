defmodule PentoWeb.ProductLive.FormComponent do
  use PentoWeb, :live_component

  alias Pento.Catalog

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Catalog.change_product(product)
    Process.sleep(250)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> allow_upload(:image,
      accept: ~w(.jpg .jpeg .png),
      max_entries: 1,
      max_file_size: 9_000_000,
      auto_upload: true,
      progress: &handle_progress/3
      )}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Catalog.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp handle_progress(:image, entry, socket) do
    :timer.sleep(500)

    IO.inspect("ENTRY")
    IO.inspect(entry)

    if entry.done? do
      path =
        consume_uploaded_entry(
          socket,
          entry,
          &upload_static_file(&1, socket)
        )

      IO.inspect("[form_component] path: #{path}")

      {:noreply, socket
       |> put_flash(:info, "file #{entry.client_name} uploaded")
       |> assign(:image_upload, path)
      }
    else
      {:noreply, socket}
    end
  end

  defp upload_static_file(%{path: path}, socket) do
    # Plug in your production image file persistence implementation here!
    dest = Path.join("priv/static/images", Path.basename(path))
    File.cp!(path, dest)
    {:ok, Routes.static_path(socket, "/images/#{Path.basename(dest)}")}
  end

  defp get_dest_filename(filename, id, type \\ "art") do
    file_extension = Path.basename(filename) |> Path.extname() |> String.downcase()
    # DBG: hms is a helper function giving a hhmmss.mmm time
    # "#{type}_#{id}_#{hms()}#{file_extension}"
  end

  defp save_product(socket, :edit, params) do
    result = Catalog.update_product(socket.assigns.product, product_params(socket, params))

    case result do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         #  Server side uses push_redirect, client side uses live_redirect
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, params) do
    case Catalog.create_product(product_params(socket, params)) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl Phoenix.LiveView
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image, ref)}
  end

  def product_params(socket, params) do
    Map.put(params, "image_upload", socket.assigns.image_upload)
  end

  def friendly_error(:too_large), do: "Image too large"
  def friendly_error(:too_many_files), do: "Too many files"
  def friendly_error(:not_accepted), do: "Unacceptable file type"
end
