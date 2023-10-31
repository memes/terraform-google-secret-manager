# frozen_string_literal: true

require 'rspec/expectations'
require 'time'

RSpec::Matchers.define :be_a_matching_superset_of do |subset|
  match do |superset|
    sanitised_superset = (superset || {}).transform_values do |v|
      v.to_s == '' ? nil : v
    end
    sanitised_subset = (subset || {}).transform_values do |v|
      v.to_s == '' ? nil : v
    end
    sanitised_subset.reject! do |k, v|
      sanitised_superset.include?(k) &&
        case v
        when nil?
          sanitised_superset.fetch(k).nil?
        when Regexp
          sanitised_superset.fetch(k).to_s.match?(v)
        else
          sanitised_superset.fetch(k) == v
        end
    end
    sanitised_subset.empty?
  end
end

# rubocop:disable Metrics/BlockLength
control 'secret' do
  title 'Ensure GCP Secret Manager secret matches expectations'
  impact 1.0
  inputs = JSON.parse(input('output_effective_inputs_json'), { symbolize_names: false })
  secret_id = input('output_secret_id')
  labels = inputs['labels'] || {}
  annotations = inputs['annotations'] || {}
  expected_replications = (inputs['replication'] || {}).transform_values do |v|
    v && !(v['kms_key_name'].nil? || v['kms_key_name'].empty?) ? v['kms_key_name'] : nil
  end
  auto_replication_kms_key_name = inputs['auto_replication_kms_key_name'] || ''
  topics = inputs['topics'] || []
  expected_expiration = input('output_expiration_timestamp') || ''
  expect_expired = !expected_expiration.empty? && (Time.parse(expected_expiration) <=> Time.now).negative?

  describe google_secret_manager_secret(project: inputs['project_id'], name: secret_id) do
    if expect_expired
      it { should_not exist }
    else
      it { should exist }
      its('labels') { should be_a_matching_superset_of(labels) } unless labels.empty?
      its('annotations') { should be_a_matching_superset_of(annotations) } unless annotations.empty?
      its('replication') { should exist }
      if expected_replications.empty?
        its('replication.automatic?') { should cmp true }
        if auto_replication_kms_key_name.empty?
          its('replication.automatic_replication.kms_key_name') { should be_nil.or be_empty }
        else
          its('replication.automatic_replication.kms_key_name') { should cmp auto_replication_kms_key_name }
        end
      else
        its('replication.user_managed?') { should cmp true }
        its('replication.to_h') { should be_a_matching_superset_of(expected_replications) }
      end
      its('topics') { should be_nil.or be_empty } if topics.empty?
      its('topics') { should cmp topics } unless topics.empty?
      its('expire_time') { should be_nil.or be_empty } if expected_expiration.empty?
      its('expire_time') { should cmp Time.parse(expected_expiration) } unless expected_expiration.empty?
    end
  end
end
# rubocop:enable Metrics/BlockLength

# rubocop:disable Metrics/BlockLength
control 'version' do
  title 'Ensure GCP Secret Manager secret version matches expectations'
  impact 1.0
  inputs = JSON.parse(input('output_effective_inputs_json'), { symbolize_names: false })
  secret_id = input('output_secret_id')
  secret_created = input('output_secret_created', value: true)
  # rubocop:disable Layout/LineLength
  expected_replication_status = (inputs['replication'] || {}).transform_values do |v|
    v && !(v['kms_key_name'].nil? || v['kms_key_name'].empty?) ? %r{^#{v['kms_key_name']}/cryptoKeyVersions/[1-9][0-9]*$} : nil
  end
  auto_replication_kms_key_version_name = inputs['auto_replication_kms_key_name'].nil? || inputs['auto_replication_kms_key_name'].empty? ? nil : %r{^#{inputs['auto_replication_kms_key_name']}/cryptoKeyVersions/[1-9][0-9]*$}
  # rubocop:enable Layout/LineLength
  expected_expiration = input('output_expiration_timestamp') || ''
  expect_expired = !expected_expiration.empty? && (Time.parse(expected_expiration) <=> Time.now).negative?

  describe google_secret_manager_secret_version(project: inputs['project_id'], name: secret_id, version: 'latest') do
    if secret_created && !expect_expired
      it { should exist }
      its('active?') { should cmp true }
      its('disabled?') { should cmp false }
      its('destroyed?') { should cmp false }
      its('replication_status') { should exist }
      if expected_replication_status.empty?
        its('replication_status.automatic?') { should cmp true }
        if auto_replication_kms_key_version_name.nil?
          its('replication_status.automatic_replication_status.kms_key_version_name') { should be_nil.or be_empty }
        else
          its('replication_status.automatic_replication_status.kms_key_version_name') do
            should match auto_replication_kms_key_version_name
          end
        end
      else
        its('replication_status.user_managed?') { should cmp true }
        its('replication_status.to_h') { should be_a_matching_superset_of(expected_replication_status) }
      end
    else
      it { should_not exist }
    end
  end
end
# rubocop:enable Metrics/BlockLength

control 'accessors' do
  title 'Ensure GCP Secret Manager secret accessor bindings match expectations'
  impact 1.0
  inputs = JSON.parse(input('output_effective_inputs_json'), { symbolize_names: false })
  secret_id = input('output_secret_id')
  accessors = inputs['accessors'] || []
  expected_expiration = input('output_expiration_timestamp') || ''
  expect_expired = !expected_expiration.empty? && (Time.parse(expected_expiration) <=> Time.now).negative?

  only_if('Secret has expired') do
    !expect_expired
  end

  only_if('accessors list was not provided.') do
    !accessors.empty?
  end

  describe google_secret_manager_secret_iam_binding(project: inputs['project_id'], name: secret_id,
                                                    role: 'roles/secretmanager.secretAccessor') do
    it { should exist }
    accessors.each do |accessor|
      its('members') { should include accessor }
    end
  end
end
