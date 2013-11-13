#-*-ruby-*-
chef.json = {
  'foo' => 'bar',
  'attribute-validator' => {
    'rules' => {
      'demfoos' => {
        'path' => '/foo',
        'required' => true,
      }
    }
  }
}

chef.run_list.push 'attribute-validator::converge-time-check'
