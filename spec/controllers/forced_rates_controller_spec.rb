# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForcedRatesController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'when params are valid' do
      let(:params) { { forced_rate: { value: 12.1234, expires_at: Time.current + 1.day } } }
      it 'returns success and redirect to admin' do
        post :create, params: params
        expect(response).to redirect_to(admin_path)
        expect(flash[:success]).to be_present
      end

      it 'sheduled deforce job' do
        ActiveJob::Base.queue_adapter = :test
        post :create, params: params
        expect(DeforceRateJob).to have_been_enqueued
      end
    end

    context 'wnen params are not valid' do
      let(:params) { { forced_rate: { value: 'none', expires_at: Time.current - 1.day } } }
      it 'returns success and redirect to admin' do
        post :create, params: params
        expect(response).to redirect_to(admin_path)
        expect(flash[:danger]).to include('Value')
        expect(flash[:danger]).to include('Expires')
      end
    end
  end
end
