# Warnings
if git.lines_of_code > 700
  warn 'Huge PR'
elsif git.lines_of_code > 500
  warn 'Large PR'
elsif git.lines_of_code > 300
  warn 'Big PR'
end

warn 'PR is classed as Work in Progress' if github.pr_title.include? '[WIP]'
warn 'Please add labels to this PR' if github.pr_labels.empty?

# Ditect Important file changed
protected_files = ['Podfile.lock', 'Cartfile.resolved', 'Gemfile.lock', 'project.yml', '.ruby-version', 'Fastfile']
protected_files.each do |file|
  message "#{file} is changed" if git.modified_files.include? file
end

# Ditect View file changed
# view_extensions = ['.xib', '.storyboard']
# has_view_changes = git.modified_files.any? { |file| view_extensions.any? { |ext| file.end_with? ext }}
# pr_has_screenshot = github.pr_body =~ /https?:\/\/\S*\.(png|jpg|jpeg|gif){1}/
# warn('見た目に変更がある場合は、スクリーンショットを添付してください。') if has_view_changes & !pr_has_screenshot

# comment by Swiftlint
github.dismiss_out_of_range_messages
swiftlint.config_file = '.swiftlint.yml'
swiftlint.binary_path = './Pods/SwiftLint/swiftlint'
swiftlint.lint_files inline_mode: true

lgtm.check_lgtm
