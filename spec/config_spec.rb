require 'spec_helper'

RSpec.describe ActsAsQuickbooksModel::Config do
  let(:config) { described_class.new(options) }

  describe "#new" do
    describe "options" do
      context 'default' do
        let(:options) { { } }

        it 'sets the doc path to `doc`' do
          expect(config.doc_path).to eq("#{ActsAsQuickbooksModel.root}/doc")
        end

        it 'sets the child paths' do
          %w(definitions migrations model_maps).each do |dir|
            expect(config.send "#{dir}_path").to eq("#{ActsAsQuickbooksModel.root}/doc/#{dir}")
          end
        end
      end

      context 'path given' do
        let(:options) { { doc_path: '/foo/bar/baz' } }

        it 'sets the doc path to the given path' do
          expect(config.doc_path).to eq("/foo/bar/baz")
        end

        it 'sets the child paths' do
          %w(definitions migrations model_maps).each do |dir|
            expect(config.send "#{dir}_path").to eq("#{options[:doc_path]}/#{dir}")
          end
        end
      end

      context 'invalid option' do
        it 'should raise an error' do
          expect{ described_class.new(invalid: 'value') }.to raise_error("Unknown option 'invalid'")
        end
      end
    end
  end
end
