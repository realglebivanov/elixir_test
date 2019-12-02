defmodule Test.Repositories.Repository do
  defmacro __using__(model) do
    quote do
      use GenServer

      def start_link(_) do
        GenServer.start_link(__MODULE__, %{records: %{}, max_id: 0}, name: __MODULE__)
      end

      def init(state), do: {:ok, state}

      def find(id), do: GenServer.call(__MODULE__, {:find, id})
      def delete(id), do: GenServer.call(__MODULE__, {:delete, id})
      def find_by(predicate), do: GenServer.call(__MODULE__, {:find_by, predicate})
      def create(attributes), do: GenServer.call(__MODULE__, {:create, attributes})
      def save(record), do: GenServer.call(__MODULE__, {:save, record})

      def handle_call({:find, id}, _from, %{records: records} = state) do
        record = records[id]
        reply = if is_nil(record), do: {:error, :not_found}, else: {:ok, record}
        {:reply, reply, state}
      end

      def handle_call({:delete, id}, _from, %{records: records, max_id: max_id} = state) do
        if Map.has_key?(records, id) do
          {:reply, :ok, %{max_id: max_id, records: Map.delete(records, id)}}
        else
          {:reply, {:error, :not_found}, state}
        end
      end

      def handle_call({:find_by, predicate}, _from, %{records: records} = state) do
        {_, record} = Enum.find(records, {nil, nil}, fn {_, record} -> predicate.(record) end)
        reply = if is_nil(record), do: {:error, :not_found}, else: {:ok, record}
        {:reply, reply, state}
      end

      def handle_call({:create, attributes}, _from, %{max_id: max_id, records: records}) do
        new_max_id = max_id + 1
        new_record = struct(unquote(model), Map.put(attributes, :id, new_max_id))
        new_records = Map.put(records, new_max_id, new_record)
        {:reply, {:ok, new_record}, %{max_id: new_max_id, records: new_records}}
      end

      def handle_call({:save, record}, _from, %{records: records} = state) do
        new_records = Map.put(records, record.id, record)
        new_state = Map.put(state, :records, new_records)
        {:reply, :ok, new_state}
      end
    end
  end
end
