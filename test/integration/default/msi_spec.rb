# https://www.inspec.io/docs/reference/resources/

# package was installed successfully
describe package('7-Zip 18.01 (x64 edition)') do
  it { should be_installed }
  its('version') { should include('18.01') }
end

# 7z.exe file is available
describe file('C:\Program Files\7-Zip\7z.exe') do
  it { should exist }
end

# 7z.exe shows the help when called with no args
describe command('& "C:\Program Files\7-Zip\7z.exe"') do
  its('stdout') { should include('7-Zip 18.01 (x64)') }
  its('stdout') { should include('Usage: 7z') }
  its('exit_status') { should eq 0 }
end

# 7z.exe successfully opens a zip archive
describe command(
  '& "C:\Program Files\7-Zip\7z.exe" e C:\synced_folder\archive.zip -aoa -oC:\\'
) do
  its('stdout') { should include('Extracting archive: C:\synced_folder\archive.zip') }
  its('stdout') { should include('Everything is Ok') }
  its('stdout') { should include('Files: 2') }
  its('stderr') { should eq('') }
  its('exit_status') { should eq 0 }
end

# the files from the zip were extracted
['a', 'b'].each do |f|
  describe file("C:\\file-#{f}.txt") do
    it { should exist }
    its('content') { should cmp("Contents of file-#{f}.txt\r\n") }
  end
end
