class ThoroughTest
  def initialize(path)
    @path = path
    head_hash = (`cd #{@path} && git show HEAD`).match(/commit ([a-z0-9]*)\n/)[1]
    `cd #{@path} && git reset --hard HEAD~1`
    `cd #{@path} && git cherry-pick -n #{head_hash}`
    `cd #{@path} && git reset HEAD`
    non_spec_files.each { |file| `cd #{@path} && git checkout #{file}` }
    @has_failures = tests_passed?
    `cd #{@path} && git reset --hard`
    `cd #{@path} && git cherry-pick #{head_hash}`
    @has_failures_in_current_project_state = tests_passed?
  end

  def latest_commits_code_was_written_by_having_failing_test_first?
    @has_failures
  end

  def passed_test_suite?
    @has_failures_in_current_project_state
  end

  private
    def non_spec_files
      @non_spec_files ||= (`cd #{@path} && git status`).
        split("\n").
        map(&:strip).
        select { |line| line.match(/modified:/) && !line.match(/spec\.rb$/) }.
        map { |l| l.match(/modified:   (.*rb)$/)[1] }
    end

    def spec_files
      @spec_files ||= (`cd #{@path} && git status`).
        split("\n").
        map(&:strip).
        select { |line| line.match(/modified:/) && line.match(/spec\.rb$/) }.
        map { |l| l.match(/modified:   (.*rb)$/)[1] }
    end

    def tests_passed?
      !`cd #{@path} && rspec #{spec_files.join(' ')}`.match(/Failures:/)
    end
end