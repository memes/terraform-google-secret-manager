# frozen_string_literal: true

control 'secret' do
  title 'Ensure GCP Secret Manager secret matches expectations'
  impact 1.0
  inputs = JSON.parse(input('output_effective_inputs_json'), { symbolize_names: false })
  secret_id = input('output_secret_id')

  labels = inputs['labels'] || {}
  replications = inputs['replication'] || []

  describe google_secret_manager_secret(project: inputs['project_id'], name: secret_id) do
    it { should exist }
    its('labels') { should be_nil.or be_empty } if labels.empty?
    its('labels') { should cmp labels } unless labels.empty?
    if replications.empty?
      its('replication.automatic?') { should cmp true }
      its('replication.automatic_replication.kms_key_name') { should be_nil.or be_empty }
    else
      its('replication.user_managed?') { should cmp true }
      # TODO
      # its('replication.user_managed_replication.kms_key_name') { should be_nil.or be_empty }
    end
  end
end

control 'version' do
  title 'Ensure GCP Secret Manager secret version matches expectations'
  impact 1.0
  inputs = JSON.parse(input('output_effective_inputs_json'), { symbolize_names: false })
  secret_id = input('output_secret_id')

  only_if('secret value was not provided.') do
    !(inputs['secret'].nil? || inputs['secret'].empty?)
  end

  describe google_secret_manager_secret_version(project: inputs['project_id'], name: secret_id, version: 'latest') do
    it { should exist }
    its('active?') { should cmp true }
    its('disabled?') { should cmp false }
    its('destroyed?') { should cmp false }
  end
end

control 'accessors' do
  title 'Ensure GCP Secret Manager secret accessor bindings match expectations'
  impact 1.0
  inputs = JSON.parse(input('output_effective_inputs_json'), { symbolize_names: false })
  secret_id = input('output_secret_id')
  accessors = inputs['accessors'] || []

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
