require File.expand_path('../../lib/thorough_test', __FILE__)

describe ThoroughTest do
  it 'passes if latest commit was written by having its tests fail when run with the previous code' do
    test = ThoroughTest.new(File.expand_path('../sample_project_that_should_not_fail', __FILE__))
    expect(test.latest_commits_code_was_written_by_having_failing_test_first?).to be(true)
  end

  it 'does not pass if latest commit was written by having its tests pass when run with the previous code' do
    test = ThoroughTest.new(File.expand_path('../sample_project_that_should_fail', __FILE__))
    expect(test.latest_commits_code_was_written_by_having_failing_test_first?).to be(false)
  end
end
