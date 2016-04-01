require 'open-uri'

class TaskPage

  # TODO: exception handling

  TaskPage_URL = "https://ctftime.org/task/".freeze

  Logger = Logging.logger(STDOUT)
  Logger.level = :info

  include MyExtension

  def self.gen_task_page_url(id)
    TaskPage_URL + id.to_s
  end

  attr_reader :state

  def initialize(id)
    @id = id
    @url = TaskPage.gen_task_page_url(id)
    @name = "Uncaptured"
    @tags = []
    @points = 0
    @event = nil
    @state = :not_processed
  end

  def start_process!
    unless @processed == :not_processed

      begin
        document = nil
        cost = mini_measure {document = Nokogiri::HTML(open(@url))}
        Logger.info "Task #{@id} successfully loaded in #{cost} seconds!"
      rescue OpenURI::HTTPError => e
        Logger.error "Page #{@url} not found on remote server."
        @state = :not_found
        return
      end

      begin
        extract_name(document)
        extract_points(document)
        extract_tags(document)
        extract_description(document)
      rescue
        Logger.error "There's some problem in Task #{@id}."
        @state = :failed
        return
      end

      # extract_writeup(document)

      @state = :processed
    end
  end

  def extract_points(document)
    if m = document.text.match(/Points: (?<points>\d+)/)
      @points = m[:points].to_i
    else
      # report a error
    end
  end

  def extract_name(document)
    @name = document.css('div.page-header>h2').children.first.text
  end

  # def extract_writeup(document)
  #   table = document.css('table.table')
  # end

  def extract_description(document)
    node = document.css('div.well>p')
    @description = node.inner_html
  end

  def extract_tags(document)
    root = document.css('span.label.label-info')
    tags = root.children.map(&:text)
    # puts tags.class
    @tags += tags
  end

  def to_object
    {id: @id,
     url: @url,
     name: @name,
     tags: @tags,
     points: @points}
  end

  def to_json(options = {})
    to_object.to_json(options)
  end

end