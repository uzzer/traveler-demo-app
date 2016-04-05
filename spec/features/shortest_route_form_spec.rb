require 'rails_helper'

feature 'Shortest route form', type: :feature do
  before do
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
      it 'has destination selector' do
        expect(page).to have_css('#destination')
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
        before do
          # TODO: add code to prepare successful submit
        end
        it 'displays correct response text'
        it 'displays shortest route length'
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
