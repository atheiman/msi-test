describe package('7-Zip 18.01 (x64 edition)') do
  it { should be_installed }
  its('version') { should eq '18.01.00.0' }
end
