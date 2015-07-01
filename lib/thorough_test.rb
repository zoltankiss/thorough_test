class ThoroughTest
  def initialize(path)
    @path = path
    head_hash = (`cd #{path} && git show HEAD`).match(/commit ([a-z0-9]*)\n/)[1]
    `cd #{path} && git reset --hard HEAD~1`
    `cd #{path} && git cherry-pick -n #{head_hash}`
    @non_spec_files = (`cd #{path} && git status`).
      split("\n").
      map(&:strip).
      select { |line| line.match(/modified:/) && !line.match(/spec\.rb$/) }.
      map { |l| l.match(/modified:   (.*rb)$/)[1] }
    `cd #{path} && git reset HEAD`
    @non_spec_files.each { |file| `cd #{path} && git checkout #{file}` }
    @spec_files = (`cd #{path} && git status`).
      split("\n").
      map(&:strip).
      select { |line| line.match(/modified:/) && line.match(/spec\.rb$/) }.
      map { |l| l.match(/modified:   (.*rb)$/)[1] }
    @has_failures = !!`cd #{path} && rspec #{@spec_files.join(' ')}`.match(/Failures:/)
    `git reset --hard`
    `git cherry-pick #{head_hash}`
  end

  def has_failed_without_the_latest_code?
    @has_failures
  end
end