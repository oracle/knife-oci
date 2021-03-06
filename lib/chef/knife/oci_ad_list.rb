# Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.

require 'chef/knife'
require 'chef/knife/oci_common_options'
require 'chef/knife/oci_helper'

class Chef
  class Knife
    # List availability domains
    class OciAdList < Knife
      banner 'knife oci ad list (options)'

      include OciHelper
      include OciCommonOptions

      deps do
        require 'oci'
      end

      def run
        options = {}
        columns = []

        list_for_display, last_response = get_display_results(options) do |client_options|
          response = identity_client.list_availability_domains(compartment_id, client_options)

          items = response_to_list(response) do |item|
            [item.name]
          end
          [response, items]
        end

        display_list_from_array(list_for_display, columns.length)
        warn_if_page_is_truncated(last_response)
      end
    end
  end
end
