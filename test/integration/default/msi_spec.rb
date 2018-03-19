# https://www.inspec.io/docs/reference/resources/

describe package('7-Zip 18.01 (x64 edition)') do
  it { should be_installed }
  its('version') { should include('18.01') }
end

describe powershell("Get-WmiObject -Class Win32_Product") do
  its('stdout') { should include('7-Zip 18.01') }
  its('exit_status') { should eq 0 }
end

describe file('C:/Program Files/7-Zip/7z.exe') do
  it { should exist }
end

describe command("& \"C:/Program Files/7-Zip/7z.exe\"") do
  its('stdout') { should include('7-Zip 18.01 (x64)') }
  its('stdout') { should include('Usage: 7z') }
  its('exit_status') { should eq 0 }
end

script = <<-EOH
  # download zip file
  (New-Object System.Net.WebClient).DownloadFile(
    "https://codeload.github.com/atheiman/msi-test/zip/master",
    "C:/master.zip"
  )
  # extract contents of zip file
  & "C:/Program Files/7-Zip/7z.exe" e C:/master.zip
EOH
describe powershell(script) do
  # its('stdout') { should include('README.md') }
  its('stderr') { should eq('') }
  its('exit_status') { should eq 0 }
end

describe file('C:/master.zip') do
  it { should exist }
end

describe file('C:/msi-test-master/README.md') do
  it { should exist }
end

describe command("& \"C:/Program Files/7-Zip/7z.exe\" l C:/master.zip") do
  its('stdout') { should include(/README\.md/) }
  its('stderr') { should eq('') }
  its('exit_status') { should eq 0 }
end
