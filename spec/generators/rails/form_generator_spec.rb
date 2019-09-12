# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rails::FormGenerator, type: :generator do
  destination(File.expand_path('../../tmp', __FILE__))

  before do
    prepare_destination
    run_generator(%w[v1/users/age])
  end

  let(:form_path) { 'spec/generators/tmp/app/forms/v1/users/age_form.rb' }
  let(:rspec_path) { 'spec/generators/tmp/spec/forms/v1/users/age_form_spec.rb' }

  describe '#generator' do
    context 'when generating app files' do
      it 'to be true when form file exists' do
        expect(File.exist?(form_path)).to eq(true)
      end

      it 'to include the proper markup' do
        form_file = File.read(form_path)
        text_snippet = 'class V1::Users::AgeForm < ApplicationForm'

        expect(form_file.include?(text_snippet)).to eq(true)
      end
    end

    context 'when generating spec files' do
      it 'to be true when form file exists' do
        expect(File.exist?(rspec_path)).to eq(true)
      end

      it 'to include the proper markup' do
        rspec_file = File.read(rspec_path)
        text_snippet = 'V1::Users::AgeForm, type: :form'

        expect(rspec_file.include?(text_snippet)).to eq(true)
      end
    end
  end

end
