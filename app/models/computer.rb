class Computer < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :mac_addr, :string
  column :cn, :string
  column :hostname, :string
  column :ard_field_1, :string
  column :ard_field_2, :string
  column :ard_field_3, :string
  column :ard_field_4, :string
  column :group, :string

  validates_presence_of :mac_addr, :cn, :hostname, :group
  validates_presence_of :ard_field_1, :ard_field_2, :ard_field_3, :ard_field_4
  validates_format_of :mac_addr, :with => /^([0-9a-f]{2}(:|$)){6}$/i

  def self.all
    response = DS_CONNECTION['/computers/get/all'].get
    database = Plist::parse_xml(response.to_s)
    database['computers'].map do |c|
      new( :mac_addr => c[1]['dstudio-mac-addr'],
           :cn => c[1]['cn'], 
           :hostname => c[1]['dstudio-hostname'],
           :ard_field_1 => c[1]['dstudio-host-ard-field-1'],
           :ard_field_2 => c[1]['dstudio-host-ard-field-2'],
           :ard_field_3 => c[1]['dstudio-host-ard-field-3'],
           :ard_field_4 => c[1]['dstudio-host-ard-field-4'],
           :group => c[1]['dstudio-group'] )
    end
  end

  def self.find(param)
    all.detect { |c| c.to_param == param.tr(':', '') }
  end

  def self.search(param)
    self.all.find_all do |c| 
      [:mac_addr, :cn, :hostname, :group, 
       :ard_field_1, :ard_field_2, :ard_field_3, :ard_field_4].detect do |f| 
        c.send(f) =~ /#{param}/i
      end
    end
  end

  def to_param
    self.mac_addr.tr(':', '')
  end

  def update_attributes(params)
    destroy if params[:mac_addr] != self.mac_addr

    self.mac_addr = params[:mac_addr]
    self.cn = params[:cn]
    self.hostname = params[:hostname]
    self.ard_field_1 = params[:ard_field_1]
    self.ard_field_2 = params[:ard_field_2]
    self.ard_field_3 = params[:ard_field_3]
    self.ard_field_4 = params[:ard_field_4]
    self.group = params[:group]

    self.save
  end

  def save
    computer_record = Group.find(self.group).settings

    computer_record['cn'] = self.device_id.upcase
    computer_record['dstudio-mac-addr'] = self.mac_addr
    computer_record['dstudio-hostname'] = self.device_id.hostname
    computer_record['dstudio-host-ard-field-1'] = self.ard_field_1
    computer_record['dstudio-host-ard-field-2'] = self.ard_field_2
    computer_record['dstudio-host-ard-field-3'] = self.ard_field_3
    computer_record['dstudio-host-ard-field-4'] = self.ard_field_4
    computer_record['dstudio-group'] = self.group

    response = DS_CONNECTION["/computers/set/entry?id=#{self.mac_addr}"].post computer_record.to_plist, :content_type => 'text/xml'
  end

  def destroy
    response = DS_CONNECTION["/computers/del/entry?id=#{self.mac_addr}"].post ""
  end

  def log
    response = DS_CONNECTION["/logs/get/entry?id=#{self.mac_addr}"].get
    database = Plist::parse_xml(response.to_s)[self.mac_addr] || ""
  end
end
