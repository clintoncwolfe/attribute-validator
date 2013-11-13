#-*-ruby-*-
chef.json = {
  'attribute-validator' => {
    'fail-action' => 'warn',
    'rules' => {
      'demfoos' => {
        'path' => '/foo',
        'required' => true,
      }
    }
  }
}

chef.run_list.push 'attribute-validator::compile-time-check'
