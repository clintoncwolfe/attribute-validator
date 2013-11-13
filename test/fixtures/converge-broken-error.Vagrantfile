#-*-ruby-*-
chef.json = {
  'attribute-validator' => {
    'fail-action' => 'error',
    'rules' => {
      'demfoos' => {
        'path' => '/foo',
        'required' => true,
      }
    }
  }
}

chef.run_list.push 'attribute-validator::converge-time-check'
