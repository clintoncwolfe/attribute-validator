#require_relative './spec_helper.rb'

describe 'converge-phase checking should work' do
  context 'when running a clean converge run' do
    output = `CAV_VAGRANTFILE_FIXTURE=converge-clean.Vagrantfile vagrant provision 2>&1 `
    status = $?
    it 'should mention the converge-time run in the info log' do
      expect(output).to match /INFO: ruby_block\[convergence time attribute validation\] called/
    end
    it 'should successfully run' do
      expect(status.exitstatus).to eql 0
    end

  end

  context 'when running a broken converge-time run' do
    context 'with the default fail action' do
      output = `CAV_VAGRANTFILE_FIXTURE=converge-broken-default.Vagrantfile vagrant provision 2>&1 `
      status = $?
      it 'should mention the converge-time run in the info log' do
        expect(output).to match /ruby_block\[convergence time attribute validation\]/
      end
      it 'should not successfully run' do
        expect(status.exitstatus).to eql 1
      end
    end

  end
end
