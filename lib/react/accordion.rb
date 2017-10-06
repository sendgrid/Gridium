require_relative '../Element'
class Accordion < Element

  def initialize(name, by, locator, opts = {})
    @name = "[ReactAccordion] #{name}"
    super(@name, by, locator, opts)
    @wait = Selenium::WebDriver::Wait.new
    @title = Element.new("[ReactAccordion] Title", :css, locator + " > div > [class=\"accordion-title\"]")
    @content = Element.new("[ReactAccordion] Content", :css, locator + " > div > [class=\"accordion-content\"]")
  end

  def get_title
    @title.text
  end

  def get_content
    @content.text
  end

  def expand_accordion
    Log.debug("[ReactAccordion] expanding #{@name} menu")
    unless expanded?
      @title.click
      @wait.until {expanded?}
    end
  end

  def collapse_accordion
    Log.debug("[ReactAccordion] collapsing #{@name} menu")
    unless collapsed?
      @title.click
      @wait.until {collapsed?}
    end
  end

  def collapsed?
    !@content.displayed?(:timeout => 0.1)
  end

  def expanded?
    @content.displayed?(:timeout => 0.1)
  end


end