require 'rails_helper'

RSpec.describe 'Items API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:bucketlist) { create(:bucketlist, created_by: user.id) }
  let!(:items) { create_list(:item, 20, bucketlist_id: bucketlist.id) }
  let(:bucketlist_id) { bucketlist.id }
  let(:id) { items.first.id }

  let(:headers) { valid_headers }

  # Test suite for GET /bucketlists/:bucketlist_id/items
  describe 'GET /bucketlists/:bucketlist_id/items' do
    before { get "/bucketlists/#{bucketlist_id}/items", headers: headers }

    context 'when bucketlist exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all bucketlist items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when bucketlist does not exist' do
      let(:bucketlist_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bucketlist/)
      end
    end
  end

  # Test suite for GET /bucketlists/:bucketlist_id/items/:id
  describe 'GET /bucketlists/:bucketlist_id/items/:id' do
    before { get "/bucketlists/#{bucketlist_id}/items/#{id}", headers: headers }

    context 'when bucketlist item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when bucketlist item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for PUT /bucketlists/:bucketlist_id/items
  describe 'POST /bucketlists/:bucketlist_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      before { post "/bucketlists/#{bucketlist_id}/items", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/bucketlists/#{bucketlist_id}/items", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /bucketlists/:bucketlist_id/items/:id
  describe 'PUT /bucketlists/:bucketlist_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before { put "/bucketlists/#{bucketlist_id}/items/#{id}", params: valid_attributes, headers: headers }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for DELETE /bucketlists/:id
  describe 'DELETE /bucketlists/:id' do
    before { delete "/bucketlists/#{bucketlist_id}/items/#{id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end