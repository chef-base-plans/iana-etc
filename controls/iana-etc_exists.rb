base_dir = input("base_dir", value: "etc")
plan_files = input("plan_files")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "iana-etc")
plan_ident = "#{plan_origin}/#{plan_name}"

hab_pkg_path = command("hab pkg path #{plan_ident}")
describe hab_pkg_path do
  its('exit_status') { should eq 0 }
  its('stdout') { should_not be_empty }
end

target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

plan_files.each do | plan_file |
  describe command("cat #{File.join(target_dir, plan_file)}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
