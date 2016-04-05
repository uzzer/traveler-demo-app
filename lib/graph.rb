# http://rosettacode.org/wiki/Dijkstra%27s_algorithm#Ruby
class Graph
  attr_reader :vertices, :edges
  Vertex = Struct.new(:name, :neighbours, :distance, :previous)

  INFINITY = Float::INFINITY.freeze

  def initialize
    @vertices = empty_hash_with_vertices_setter
    @edges = {}
    @last_calculated_source = nil
  end

  def fill_from_array(array)
    check_input_format(array)
    array.each do |source, destination, distance|
      add_edge source, destination, distance
    end
    self
  end

  def check_input_format(array)
    fail 'Wrong array format' if array.any? do |element|
      element.length != 3
    end
    fail 'Wrong arguments' if array.any? do |element|
      distance = element[2]
      distance.is_a?(Numeric) ? distance < 0 : true
    end
  end

  def add_edge(source, destination, distance)
    @vertices[source].neighbours << destination
    @edges[[source, destination]] = distance
    @edges[[destination, source]] = distance
  end

  def empty_hash_with_vertices_setter
    Hash.new { |h, k| h[k] = Vertex.new(k, [], INFINITY) }
  end

  def calculate_distances_from(source)
    return if @last_calculated_source == source

    unvisited_vertices = initialize_unvisited_vertices_index
    @vertices[source].distance = 0.0
    until unvisited_vertices.empty?
      closest_vertex = unvisited_vertices.min_by(&:distance)
      break if vertex_is_not_reachable(closest_vertex)
      unvisited_vertices.delete(closest_vertex)
      calc_distances_to_neighbour(closest_vertex, unvisited_vertices)
    end

    @last_calculated_source = source
  end

  def calc_distances_to_neighbour(source, _unvisited_vertices)
    source.neighbours.each do |neighbour_id|
      neighbour_vertex = @vertices[neighbour_id]

      found_distance_to_neighbour =
        source.distance + @edges[[source.name, neighbour_id]]
      current_minimal_distance_to_neighbour = neighbour_vertex.distance
      next unless
        found_distance_to_neighbour < current_minimal_distance_to_neighbour

      neighbour_vertex.distance = found_distance_to_neighbour
      neighbour_vertex.previous = source.name
    end
  end

  def vertex_is_not_reachable(vertex)
    vertex.distance == INFINITY
  end

  def initialize_unvisited_vertices_index
    vertices = @vertices.values
    vertices.each do |vertex|
      vertex.distance = INFINITY
      vertex.previous = nil
    end
    vertices
  end

  def shortest_path(source, target)
    path = path_to_vertex(source, target)
    distance = @vertices[target].distance
    success = distance != Float::INFINITY
    [success, path, distance]
  end

  def path_to_vertex(source, target)
    calculate_distances_from(source)
    path = []
    current_vertex = target
    while current_vertex
      path.unshift(current_vertex)
      current_vertex = @vertices[current_vertex].previous
    end
    path
  end
end
