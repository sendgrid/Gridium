require_relative '../../lib/page'
class AccordionStoryBookPage < Page

  def initialize
    @wait = Selenium::WebDriver::Wait.new
    @wait.until {Page.has_css? "[role=\"accordion-outermost-menu\"]"}
    @overloaded_accordion = Accordion.new("the outermost accordion", :css, "[role=\"accordion-outermost-menu\"]")
    @foo_accordion = Accordion.new("the foo accordion", :css, "[role=\"accordion-foo-menu\"]")
    @bar_accordion = Accordion.new("the bar accordion", :css, "[role=\"accordion-bar-menu\"]")
    @baz_accordion = Accordion.new("the baz accordion", :css, "[role=\"accordion-baz-menu\"]")
  end

  def expand_each_accordion
    Log.debug("[ME] expanding each accordion")
    expand_outer_menu
    expand_foo_menu
    expand_bar_menu
    expand_baz_menu
  end

  def collapse_each_accordion
    collapse_outer_menu
    collapse_foo_menu
    collapse_bar_menu
    collapse_baz_menu
  end

  def expand_outer_menu
    @overloaded_accordion.expand_accordion
  end

  def collapse_outer_menu
    @overloaded_accordion.collapse_accordion
  end

  def expand_foo_menu
    @foo_accordion.expand_accordion
  end

  def get_foo_title
    @foo_accordion.get_title
  end

  def get_foo_content
    @foo_accordion.get_content
  end

  def collapse_foo_menu
    @foo_accordion.collapse_accordion
  end

  def expand_bar_menu
    @bar_accordion.expand_accordion
  end

  def get_bar_title
    @bar_accordion.get_title
  end

  def get_bar_content
    @bar_accordion.get_content
  end

  def collapse_bar_menu
    @bar_accordion.collapse_accordion
  end

  def expand_baz_menu
    @baz_accordion.expand_accordion
  end

  def get_baz_title
    @baz_accordion.get_title
  end

  def get_baz_content
    @baz_accordion.get_content
  end
  def collapse_baz_menu
    @baz_accordion.collapse_accordion
  end

end