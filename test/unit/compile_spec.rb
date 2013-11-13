
system('vagrant up')

describe 'compile-phase checking should work' do
  context 'when running a clean compile run' do
    output = `CAV_VAGRANTFILE_FIXTURE=compile-clean.Vagrantfile vagrant provision 2>&1 `
    status = $?
    it 'should mention the compile-time run in the info log' do
      expect(output).to match /INFO: Running compile-time node attribute validations/
    end
    it 'should successfully run' do
      expect(status.exitstatus).to eql 0
    end

  end

  context 'when running a broken compile run' do
    context 'with the default fail action' do
      output = `CAV_VAGRANTFILE_FIXTURE=compile-broken-default.Vagrantfile vagrant provision 2>&1 `
      status = $?
      it 'should mention the compile-time run in the info log' do
        expect(output).to match /INFO: Running compile-time node attribute validations/
      end
      it 'should not successfully run' do
        expect(status.exitstatus).to eql 1
      end
    end

    context 'with the "error" fail action' do
      output = `CAV_VAGRANTFILE_FIXTURE=compile-broken-error.Vagrantfile vagrant provision 2>&1 `
      status = $?
      it 'should mention the compile-time run in the info log' do
        expect(output).to match /INFO: Running compile-time node attribute validations/
      end
      it 'should not successfully run' do
        expect(status.exitstatus).to eql 1
      end
    end

    context 'with the "warn" fail action' do
      output = `CAV_VAGRANTFILE_FIXTURE=compile-broken-warn.Vagrantfile vagrant provision 2>&1 `
      status = $?
      it 'should mention the compile-time run in the info log' do
        expect(output).to match /INFO: Running compile-time node attribute validations/
      end
      it 'should include a warning mentioning the rule violation in the log' do
        expect(output).to match /WARN: Violation: demfoos/
      end

      it 'should successfully run' do
        expect(status.exitstatus).to eql 0
      end
    end


  end
end
