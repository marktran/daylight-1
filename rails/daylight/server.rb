##
# Include into Rails server to handle and execute Daylight::API queries

# Modules requireed to handle Daylight::API queries
require 'daylight/helpers'
require 'daylight/params'
require 'daylight/refiners'

# Extensions, fixes and patches on Rails to needed for Daylight::Server
require 'extensions/array_ext'
require 'extensions/autosave_association_fix'
require 'extensions/has_one_serializer_ext'
require 'extensions/nested_attributes_ext'
require 'extensions/read_only_attributes'
require 'extensions/render_json_meta'
require 'extensions/route_options'