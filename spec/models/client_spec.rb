# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should validate_presence_of :phone }
  it { should validate_presence_of :fullname }

  describe 'class methods' do
    subject { described_class }

    describe '.validate_param' do
      context 'method was called without params' do
        it 'should return false' do
          expect(subject.validate_param({})).to be_falsey
        end
      end

      context 'method was called with incorrect param' do
        it 'should return false' do
          expect(subject.validate_param({ bad_param: 'bad_value' })).to be_falsey
        end
      end

      context 'method was called with email param' do
        let(:validation_result) { 'validation_result' }
        let(:params_for_validation) { { 'email' => 'email@example.com' } }

        before do
          allow(Client).to receive(:validate_email_uniqueness).and_return(validation_result)
        end

        it 'should call .validate_email_uniqueness' do
          expect(Client).to receive(:validate_email_uniqueness)

          subject.validate_param(params_for_validation)
        end

        it 'should return .validate_email_uniqueness method result' do
          expect(subject.validate_param(params_for_validation)).to eq validation_result
        end
      end

      context 'method was called with phone param' do
        let(:validation_result) { 'validation_result' }
        let(:params_for_validation) { { 'phone' => '111111' } }

        before do
          allow(Client).to receive(:validate_phone_uniqueness).and_return(validation_result)
        end

        it 'should call .validate_phone_uniqueness' do
          expect(Client).to receive(:validate_phone_uniqueness)

          subject.validate_param(params_for_validation)
        end

        it 'should return .validate_phone_uniqueness method result' do
          expect(subject.validate_param(params_for_validation)).to eq validation_result
        end
      end
    end

    describe '.validate_email_uniqueness' do
      let(:saved_email) { 'saved_email@example.com' }
      before { create(:client, email: saved_email) }

      context 'user with email in params exists' do
        it 'should return false' do
          expect(subject.validate_email_uniqueness(saved_email)).to be_falsey
        end
      end

      context 'user with email in params does not exist' do
        it 'should return true' do
          expect(subject.validate_email_uniqueness('new_email@example.come')).to be_truthy
        end
      end
    end

    describe '.validate_phone_uniqueness' do
      let(:saved_phone) { '111111' }
      before { create(:client, phone: saved_phone) }

      context 'user with email in params exists' do
        it 'should return false' do
          expect(subject.validate_phone_uniqueness(saved_phone)).to be_falsey
        end
      end

      context 'user with email in params does not exist' do
        it 'should return true' do
          expect(subject.validate_phone_uniqueness('222222')).to be_truthy
        end
      end
    end
  end
end
