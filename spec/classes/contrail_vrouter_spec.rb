#
# Copyright (C) 2016 Red Hat Inc. <licensing@redhat.com>
#
# Author: Alex Schultz <aschultz@redhat.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
require 'spec_helper'

describe 'contrail::vrouter' do
  shared_examples 'contrail::vrouter' do
    context 'with default paramters' do
      it { is_expected.to contain_class('contrail::vrouter') }
      it { is_expected.to contain_anchor('contrail::vrouter::start') }
      it { is_expected.to contain_class('contrail::vrouter::install') }
      it { is_expected.to contain_class('contrail::vrouter::config') }
      it { is_expected.to contain_class('contrail::vrouter::service') }
      it { is_expected.to contain_anchor('contrail::vrouter::end') }
    end
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      it_behaves_like 'contrail::vrouter'
    end
  end
end