RSpec.describe RubyCsv do
  it 'has a version number' do
    expect(RubyCsv::VERSION).not_to be nil
  end

  it 'phone_number_format returns number to be E.164 format or return invalid number' do
    number = RubyCsv.send(:phone_number_format, '(303) 887 3456')
    expect(number).to eq('+13038873456')

    number = RubyCsv.send(:phone_number_format, '303-333-9987')
    expect(number).to eq('+13033339987')

    number = RubyCsv.send(:phone_number_format, '13039873345')
    expect(number).to eq('+13039873345')

    number = RubyCsv.send(:phone_number_format, nil)
    expect(number).to eq('Invalid number')
  end

  it 'parse DateTime to return yyyy-mm-dd' do
    date = RubyCsv.send(:date_format, '12/12/2010')
    expect(date).to eq('2010-12-12')

    date = RubyCsv.send(:date_format, '1988-02-12')
    expect(date).to eq('1988-02-12')

    date = RubyCsv.send(:date_format, '6/6/99')
    expect(date).to eq('1999-06-06')

    date = RubyCsv.send(:date_format, '1-11-88')
    expect(date).to eq('1988-01-11')

    date = RubyCsv.send(:date_format, '')
    expect(date).to eq(nil)
  end

  it 'clean formats a hash key values' do
    hash = RubyCsv.send(:clean, {
                          'first_name' => 'Brent ',
                          'last_name' => ' Wilson',
                          'dob' => '1/1/1988',
                          'member_id' => 'jk 909009',
                          'effective_date' => '9/30/19',
                          'expiry_date' => '1-11-88',
                          'phone_number' => '(303) 887 3456'
                        })

    expect(hash).to eq({
                         'dob' => '1988-01-01',
                         'effective_date' => '2019-09-30',
                         'expiry_date' => '1988-01-11',
                         'first_name' => 'Brent',
                         'last_name' => 'Wilson',
                         'member_id' => 'jk909009',
                         'phone_number' => '+13038873456'
                       })
  end
end
