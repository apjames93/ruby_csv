RSpec.describe RubyCsv do
  it "has a version number" do
    expect(RubyCsv::VERSION).not_to be nil
  end

  it "phone_number_format returns number to be E.164 format or return invalid number" do
    number = RubyCsv.send(:phone_number_format, '(303) 887 3456')
    expect(number).to eq('+13038873456')

    number = RubyCsv.send(:phone_number_format, '303-333-9987')
    expect(number).to eq('+13033339987')

    number = RubyCsv.send(:phone_number_format, '13039873345')
    expect(number).to eq('+13039873345')

    number = RubyCsv.send(:phone_number_format, nil)
    expect(number).to eq('Invalid number')
  end

end
