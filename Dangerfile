warn('PR is classed as Work in Progress') if github.pr_title.include? '[WIP]'
warn('a large PR') if git.lines_of_code > 500

# Ditect Important file changed
protected_files = ['Podfile.lock', 'Cartfile.resolved', 'Gemfile.lock', 'project.yml', '.ruby-version']
protected_files.each do |file|
  message "#{file} is changed" if git.modified_files.grep(/#{file}/).present?
end

# Ditect View file changed
view_extensions = ['.xib', '.storyboard']
has_view_changes = git.modified_files.any? { |file| view_extensions.any? { |ext| file.end_with? ext }}
pr_has_screenshot = github.pr_body =~ /https?:\/\/\S*\.(png|jpg|jpeg|gif){1}/
warn('見た目に変更がある場合は、スクリーンショットを添付してください。') if has_view_changes & !pr_has_screenshot

# comment by Swiftlint
github.dismiss_out_of_range_messages
swiftlint.config_file = '.swiftlint.yml'
swiftlint.binary_path = './Pods/SwiftLint/swiftlint'
swiftlint.lint_files inline_mode: true

lgtm.check_lgtm
