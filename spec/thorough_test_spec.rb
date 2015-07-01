require File.expand_path('../../lib/thorough_test', __FILE__)

describe ThoroughTest do
  it 'passes if latest spec updates fail without the latest code' do
    test = ThoroughTest.new(File.expand_path('../sample_project_that_should_not_fail', __FILE__))
    expect(test).to have_failed_without_the_latest_code
  end

  it 'does not pass if latest spec updates pass without the latest code' do
    test = ThoroughTest.new(File.expand_path('../sample_project_that_should_fail', __FILE__))
    expect(test).to_not have_failed_without_the_latest_code
  end
end
