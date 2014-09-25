#
# Cookbook Name:: rhsm
# Library:: default
#
# Copyright (C) 2014 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module RHSM
  module Helper

    # Evaluate the the block at compile time, depending on the
    # value of rhsm/compile_time
    #
    # @example
    #   potentially_at_compile_time do
    #     package 'apache2'
    #   end
    #
    # @param [Proc] block
    #   the thing to eval
    #
    def potentially_at_compile_time(&block)
      if !!node['rhsm']['compile_time']
        CompileTime.new(self).evaluate(&block)
      else
        instance_eval(&block)
      end
    end

    private

    #
    # A class graciously borrowed from Chef Sugar for evaluating a resource at
    # compile time in a block.
    #
    class CompileTime
      def initialize(recipe)
        @recipe = recipe
      end

      def evaluate(&block)
        instance_eval(&block)
      end

      def method_missing(m, *args, &block)
        resource = @recipe.send(m, *args, &block)
        if resource.is_a?(Chef::Resource)
          actions  = Array(resource.action)
          resource.action(:nothing)

          actions.each do |action|
            resource.run_action(action)
          end
        end
        resource
      end
    end
  end
end

# Include the timing module into the main recipe DSL
::Chef::Recipe.send(:include, RHSM::Helper)
