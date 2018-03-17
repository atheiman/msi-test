# https://docs.chef.io/resource_windows_package.html
windows_package 'name' do
  checksum 'b23f97c230a921f834550d2bf467d313952861f641f49ca93ccddd9d2e0300e2'
  installer_type :msi
  options '/quiet'

  # install MSI from URL
  # source 'https://www.7-zip.org/a/7z1801-x64.msi'
  # install MSI from synced folder
  # https://github.com/test-kitchen/kitchen-vagrant#-synced_folders
  source 'C:\\synced_folder\7z1801-x64.msi'
end
