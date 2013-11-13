#-*-ruby-*-
chef.json = {
  'attribute-validator' => {
    'rules' => {
      'demfoos' => {
        'path' => '/foo',
        'required' => true,
      }
    }
  }
}

chef.run_list.push 'attribute-validator::compile-time-check'
