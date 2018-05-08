class SerializableReport < JSONAPI::Serializable::Resource
  type 'reports'
  # This is the whitelist of attributes that will be served.
  # Given this example, the :created_at and :updated_at fields will not be served
  attributes :state, :city, :weather, :articles, :events, :photos

end
