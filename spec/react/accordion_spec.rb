require 'spec_helper'
require 'page_objects/accordion_story_book_page'
require 'react/accordion'
require 'securerandom'



class Accordion
  attr_accessor :title, :content, name
end

describe Accordion do
  let(:destination) {"http://localhost:6006/?selectedKind=Accordion&selectedStory=Standard"}
  let(:storybook_iframe_id) {"storybook-preview-iframe"}
  let(:accordion) {Accordion.new("an abstract react accordion", :css, "[role=\"accordion-undefined\"]")}
  let(:content) {"Leverage agile frameworks to provide a robust synopsis for high level overviews.\nIterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.\nOrganically grow the holistic world view of disruptive innovation via workplace diversity and empowerment."}


  before :all do
    Gridium.config.browser_source = :local
    Gridium.config.browser = :chrome
  end

  before(:each) do
    Driver.visit(destination)
    Driver.switch_to_frame(:id, storybook_iframe_id)
  end

  after(:each) do
    Driver.quit
  end

  describe "An abstract accordion model" do

    context 'when the accordion is collapsed' do
      it 'will not show the accordion content' do
        expect(accordion.content.displayed?(:timeout => 1)).to eq false
      end

      it 'will expand to show the accordion content' do
        accordion.expand_accordion
        expect(accordion.content.displayed?(:timeout => 1)).to eq true
      end
    end

    context 'when the accordion is expanded' do

      before(:each) do
        accordion.expand_accordion
      end

      it 'will collapse to hide the accordion content' do
        accordion.collapse_accordion
        expect(accordion.content.displayed?(:timeout => 1)).to eq false
      end

      it 'will show the accordion content' do
        expect(accordion.content.displayed?(:timeout => 1)).to eq true
      end

    end
  end


  describe 'a complex explicit accordion page' do

    context 'when the accordion is nested' do
      let(:destination) {"http://localhost:6006/?selectedKind=Accordion&selectedStory=NestedWithPurpose"}
      let(:accordion_page) {AccordionStoryBookPage.new}

      it 'will show all expanded children' do
        accordion_page.expand_each_accordion
        aggregate_failures do
          expect(accordion_page.get_foo_content).to eq "content for foo"
          expect(accordion_page.get_bar_content).to eq "content for bar"
          expect(accordion_page.get_baz_content).to eq "content for baz"
        end
      end

      it 'an expanded child remains so when a parent is collapsed' do
        accordion_page.expand_each_accordion
        accordion_page.collapse_outer_menu
        accordion_page.expand_outer_menu
        aggregate_failures do
          expect(accordion_page.get_foo_content).to eq "content for foo"
          expect(accordion_page.get_bar_content).to eq "content for bar"
          expect(accordion_page.get_baz_content).to eq "content for baz"
        end
      end
    end
  end
end
