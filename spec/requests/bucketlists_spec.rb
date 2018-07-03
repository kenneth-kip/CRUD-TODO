require 'rails_helper'

RSpec.describe 'Bucketlists API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:bucketlists) { create_list(:bucketlist, 10, created_by: user.id) }
  let(:bucketlist_id) { bucketlists.first.id }

  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /bucketlists
  describe 'GET /bucketlists' do
    # make HTTP get request before each example
    before { get '/v1/bucketlists/', params: {}, headers: headers }

    it 'returns bucketlists' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      response
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /bucketlists/:id
  describe 'GET /bucketlists/:id' do
    before { get "/v1/bucketlists/#{bucketlist_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the bucketlists' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(bucketlist_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:bucketlist_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bucketlist/)
      end
    end
  end

  # Test suite for POST /bucketlists
  describe 'POST /bucketlists' do
    # valid payload
    let(:valid_attributes) { { name: 'Cambodia' } }
  
    context 'when the request is valid' do
      before { post '/v1/bucketlists', params: { name: 'Cambodia'}, headers: headers}

      it 'creates a bucketlist' do
        expect(json['name']).to eq('Cambodia')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT /bucketlists/:id
  describe 'PUT /bucketlists/:id' do
    let(:valid_attributes) { { name: 'Singapore' } }

    context 'when the record exists' do
      before { put "/v1/bucketlists/#{bucketlist_id}", params: { name: 'Singapore' }.to_json, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /bucketlists/:id
  describe 'DELETE /bucketlists/:id' do
    before { delete "/v1/bucketlists/#{bucketlist_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end