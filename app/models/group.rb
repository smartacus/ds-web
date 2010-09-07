class Group
  attr_reader :id, :settings

  def self.all
    response = DS_CONNECTION['/computers/groups/get/all'].get
    database = Plist::parse_xml(response.to_s)
    groups = database['groups'].map do |g|
      new(g)
    end
  end

  def self.find(param)
    all.detect { |c| c.to_param == param }
  end

  def self.default
    response = DS_CONNECTION['/computers/groups/get/default'].get
    database = Plist::parse_xml(response.to_s)
    database['default']
  end

  def initialize(group)
    @id = group

    response = DS_CONNECTION['/computers/get/all'].get
    database = Plist::parse_xml(response.to_s)

    @settings = database['groups'][group]
  end

  def to_param
    @id
  end
end
