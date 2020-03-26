defmodule RobotSimulator do
  @directions [:north, :south, :west, :east]

  def create(), do: build_robot(:north, {0, 0})

  def create(direction, {x, y} = position)
      when direction in @directions and is_number(x) and is_number(y) do
    build_robot(direction, position)
  end

  def create(direction, _position) when direction in @directions do
    {:error, "invalid position"}
  end

  def create(_direction, _position) do
    {:error, "invalid direction"}
  end

  def simulate(robot, instructions) do
    instructions
    |> prepare_commands()
    |> run(robot)
  end

  def direction(%{direction: direction} = _robot), do: direction

  def position(%{position: position} = _robot), do: position

  defp prepare_commands(instructions), do: String.graphemes(instructions)

  defp run([], robot), do: robot

  defp run(_, {:error, _reason} = response), do: response

  defp run(
         [instrunction | next_commands],
         %{direction: last_direction, position: position} = _robot
       ) do
    new_robot_configs =
      case instrunction do
        "L" -> build_robot(turn_left(last_direction), position)
        "R" -> build_robot(turn_right(last_direction), position)
        "A" -> build_robot(last_direction, move_forward(last_direction, position))
        _ -> {:error, "invalid instruction"}
      end

    run(next_commands, new_robot_configs)
  end

  defp move_forward(direction, {x, y}) do
    case(direction) do
      :north -> {x, y + 1}
      :west -> {x - 1, y}
      :south -> {x, y - 1}
      :east -> {x + 1, y}
    end
  end

  defp turn_left(direction) do
    case(direction) do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
    end
  end

  defp turn_right(direction) do
    case(direction) do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end

  defp build_robot(direction, position) do
    %{
      direction: direction,
      position: position
    }
  end
end
