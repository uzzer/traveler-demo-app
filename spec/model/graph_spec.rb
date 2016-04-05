require 'rails_helper'

describe Graph do
  describe 'fill_from_array' do
    context 'wrong input' do
      wrong_data = {
        not_array: :a,
        malformed_array: [[:a], [:foo, :bar]],
        wrong_data_type: [[:a, :b, :c], [:a, :c, 3]],
        negative_distances: [[:a, :b, -2], [:a, :c, 3]]
      }
      wrong_data.each do |error_name, input|
        it "fails to be initialized with #{error_name.to_s.tr('_', ' ')}" do
          expect { Graph.new.fill_from_array(input) }.to raise_error
        end
      end
    end
    context 'correct input' do
      let(:graph) { Graph.new.fill_from_array([[:a, :b, 1], [:b, :c, 2]]) }
      let(:expected_vertices) do
        {
          a: Graph::Vertex.new(:a, [:b], Float::INFINITY, nil),
          b: Graph::Vertex.new(:b, [:c], Float::INFINITY, nil)
        }
      end

      let(:expected_edges) do
        {
          [:a, :b] => 1,
          [:b, :a] => 1,
          [:b, :c] => 2,
          [:c, :b] => 2
        }
      end

      it 'parses vertices correctly' do
        expect(graph.vertices).to eq expected_vertices
      end

      it 'parses edges correctly' do
        expect(graph.edges).to eq expected_edges
      end
    end

    context 'route finder algorithm' do
      context 'single node' do
        let(:graph) { Graph.new.fill_from_array([[1, 2, 5]]) }
        context 'successfully' do
          it 'finds route in correct direction' do
            success, _, distance =
              graph.shortest_path(1, 2)
            expect(success).to be true
            expect(distance).to eq 5
          end
          it 'finds route self to self' do
            success, _, distance =
              graph.shortest_path(1, 1)
            expect(success).to be true
            expect(distance).to eq 0
          end
        end
        context 'fails' do
          it 'cannot find route in incorrect direction' do
            expect(graph.shortest_path(2, 1)[0]).to be false
          end
          it 'cannot find route to unknown node' do
            expect(graph.shortest_path(1, 5)[0]).to be false
          end
        end
      end

      context 'two nodes' do
        let(:graph) { Graph.new.fill_from_array([[1, 2, 5], [2, 3, 4]]) }
        context 'successfully' do
          it 'finds route in correct direction' do
            success, _, distance =
              graph.shortest_path(1, 3)
            expect(success).to be true
            expect(distance).to eq 9
          end
          it 'finds route from middle' do
            success, _, distance =
              graph.shortest_path(2, 3)
            expect(success).to be true
            expect(distance).to eq 4
          end
        end
        context 'fails' do
          it 'cannot find route in incorrect direction' do
            expect(graph.shortest_path(3, 1)[0]).to be false
          end
        end
      end

      context 'shortest route situation' do
        let(:graph) do
          Graph.new.fill_from_array(
            [
              [1, 2, 1],
              [2, 3, 10],
              [2, 4, 1],
              [3, 5, 1],
              [4, 5, 1]
            ]
          )
        end
        context 'successfully' do
          it 'finds route in correct direction' do
            success, _, distance =
              graph.shortest_path(1, 5)
            expect(success).to be true
            expect(distance).to eq 3
          end
          it 'finds route from middle' do
            success, _, distance =
              graph.shortest_path(2, 5)
            expect(success).to be true
            expect(distance).to eq 2
          end
        end
        context 'fails' do
          it 'cannot find route in incorrect direction' do
            expect(graph.shortest_path(5, 1)[0]).to be false
          end
        end
      end

      context 'distance overflow' do
        let(:graph) do
          Graph.new.fill_from_array([[1, 2, Float::MAX], [2, 3, Float::MAX]])
        end
        it 'handles buffer overflow situations' do
          expect(graph.shortest_path(1, 3)[0]).to be false
        end
      end
    end
  end
end
