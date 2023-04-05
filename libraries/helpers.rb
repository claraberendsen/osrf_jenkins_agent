#
# Copyright:: 2020, Open Source Robotics Foundation.
#
#
module OSRFJenkinsAgent
  module Helpers
    # List nvidia devices present on the system.
    #
    # @return [Array]
    def nvidia_devices
      node['gpu_devices'].select do |_, dev|
        dev['vendor'] =~ /nvidia/i
      end
    end

    # Determines if an NVIDIA card is detected on the system
    #
    # @return [Boolean]
    def has_nvidia_support?
      if ENV['CHEF_TEST_FAKE_NVIDIA_SUPPORT'] == 'true'
        return true
      end
      nvidia_devices.any?
    end

    # Determines if an NVIDIA card GRID is detected on the system
    # The model is the one in AWS nodes
    #
    # @return [Boolean]
    def has_nvidia_grid_support?
      nvidia_devices.any? { |_, dev| dev['device'] =~ /GRID/ }
    end
  end
end

Chef::DSL::Recipe.include ::OSRFJenkinsAgent::Helpers
Chef::Resource.include ::OSRFJenkinsAgent::Helpers
