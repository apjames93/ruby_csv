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

  it "parse DateTime to return yyyy-mm-dd" do
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
end
