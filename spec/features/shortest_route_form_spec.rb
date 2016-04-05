require 'rails_helper'

feature 'Shortest route form', type: :feature do
  let(:city_name_one) { Faker::Address.city  }
  let(:city_name_two) { Faker::Address.city  }
  before do
    create(:city, name: city_name_one)
    create(:city, name: city_name_two)
    visit shortest_route_lookup_path
  end
  describe 'UI' do
    it 'has query form with correct id' do
      page.has_css?('#route_finder_form')
    end
    describe 'form' do
      it 'has source selector' do
        expect(page).to have_css('#source')
      end
      it 'has correct set of options in source' do
        expect(page).to(
          have_selector(
            'source',
            options: [city_name_one, city_name_two]
          )
        )
      end
      it 'has destination selector' do
        expect(page).to have_css('#destination')
      end
      it 'has correct set of options in destination' do
        expect(page).to(
          have_selector(
            'destination',
            options: [city_name_one, city_name_two]
          )
        )
      end
      it 'has submit button' do
        expect(page).to have_css('#submit_query')
      end
      it 'submits on button' do
        click_on('Submit')
        expect(current_path).to eq shortest_route_result_path
      end
    end
    context 'submitted form' do
      context 'successful form' do
        let(:success_text) { 'Connection found' }
        let!(:city_a) { create(:city) }
        let!(:city_b) { create(:city) }
        let!(:route_1) do
          create(:route,
                 source_city: city_a,
                 destination_city: city_b)
        end
        before do
          visit shortest_route_lookup_path
          select city_a.name, from: 'source'
          select city_b.name, from: 'destination'
          click_on('Submit')
        end
        it 'displays correct response text' do
          expect(page).to have_content(success_text)
        end
        it 'displays shortest route length' do
          expect(page).to have_content(route_1.distance)
        end
      end
      context 'non successful form' do
        before do
          # TODO: add code to prepare non successful submit
        end
        it 'displays correct unsuccessful response meessage'
      end
    end
  end
end
